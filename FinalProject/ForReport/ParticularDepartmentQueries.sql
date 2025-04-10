--A department Info 
SELECT Department.Name, Department.Location, Department.Contact, Hospital.Name AS HospitalName, COUNT(Doctor.DoctorID) AS DoctorCount
FROM Department
JOIN Hospital ON Hospital.HospitalID = Department.HospitalID
JOIN DoctorDepartmentAssignment ON DoctorDepartmentAssignment.DepartmentID = Department.DepartmentID
JOIN Doctor ON Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID
WHERE Department.DepartmentID = 10
GROUP BY Department.Name, Department.Location, Department.Contact, Hospital.Name;

--Popular Doctors of that department by their ppointments
select Person.FirstName , count(Appointment.AppointmentID) as totalAppointments from Doctor join DoctorDepartmentAssignment on Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Person on Person.UserID = Doctor.DoctorID join Users on Person.UserID = Users.UserID join Appointment on Appointment.DoctorID = Doctor.DoctorID join Patient on Patient.PatientID = Appointment.PatientID join PatientSymptoms on PatientSymptoms.PatientID = Patient.PatientID join Prescription on Prescription.SymptomID = PatientSymptoms.SymptomID join Invoice on Invoice.InvoiceID = Prescription.PrescriptionID where Department.DepartmentID = 10 group by person.FirstName;

--Contriubution of that department in its respective hospital
select Department.Name , Department.HospitalID  from Department join Hospital on Hospital.HospitalID = Department.HospitalID where Department.DepartmentID = 5

SELECT Department.DepartmentID , Department.Name, Department.HospitalID , sum(Invoice.TotalAmount) as TotalAmountInDeptGain
FROM Department join DoctorDepartmentAssignment on DoctorDepartmentAssignment.DepartmentID = Department.DepartmentID join Doctor on Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID join Appointment on Appointment.DoctorID = Doctor.DoctorID join patient on Patient.PatientID = Appointment.PatientID join PatientSymptoms on PatientSymptoms.PatientID = Patient.PatientID join Prescription on Prescription.SymptomID = PatientSymptoms.SymptomID join Invoice on Invoice.InvoiceID = Prescription.PrescriptionID
WHERE Department.HospitalID = (
    SELECT HospitalID
    FROM Department
    WHERE DepartmentID = 6 -- Replace with the user's provided DepartmentID
) group by Department.Name ,Department.HospitalID ,Department.DepartmentID;



WITH DepartmentContribution AS (
    SELECT
        Department.DepartmentID,
        Department.Name,
        SUM(Invoice.TotalAmount) AS TotalAmountInDept,
        Department.HospitalID
    FROM
        Department
        JOIN DoctorDepartmentAssignment ON DoctorDepartmentAssignment.DepartmentID = Department.DepartmentID
        JOIN Doctor ON Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID
        JOIN Appointment ON Appointment.DoctorID = Doctor.DoctorID
        JOIN Patient ON Patient.PatientID = Appointment.PatientID
        JOIN PatientSymptoms ON PatientSymptoms.PatientID = Patient.PatientID
        JOIN Prescription ON Prescription.SymptomID = PatientSymptoms.SymptomID
        JOIN Invoice ON Invoice.InvoiceID = Prescription.PrescriptionID
    WHERE
        Department.HospitalID = (
            SELECT HospitalID
            FROM Department
            WHERE DepartmentID = 1-- Replace with the user's provided DepartmentID
        )
    GROUP BY
        Department.DepartmentID,
        Department.Name,
        Department.HospitalID
),
TotalHospitalInvoice AS (
    SELECT
        SUM(Invoice.TotalAmount) AS TotalHospitalAmount,
        Department.HospitalID
    FROM
        Department
        JOIN DoctorDepartmentAssignment ON DoctorDepartmentAssignment.DepartmentID = Department.DepartmentID
        JOIN Doctor ON Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID
        JOIN Appointment ON Appointment.DoctorID = Doctor.DoctorID
        JOIN Patient ON Patient.PatientID = Appointment.PatientID
        JOIN PatientSymptoms ON PatientSymptoms.PatientID = Patient.PatientID
        JOIN Prescription ON Prescription.SymptomID = PatientSymptoms.SymptomID
        JOIN Invoice ON Invoice.InvoiceID = Prescription.PrescriptionID
    WHERE
        Department.HospitalID = (
            SELECT HospitalID
            FROM Department
            WHERE DepartmentID = 1 -- Replace with the user's provided DepartmentID
        )
    GROUP BY
        Department.HospitalID
)
SELECT
    DC.DepartmentID,
    DC.Name AS DepartmentName,
    DC.TotalAmountInDept AS DepartmentTotal,
    (DC.TotalAmountInDept * 100.0) / THI.TotalHospitalAmount AS ContributionPercentage,
    100 - ((DC.TotalAmountInDept * 100.0) / THI.TotalHospitalAmount) AS OtherContribution
FROM
    DepartmentContribution DC
    CROSS JOIN TotalHospitalInvoice THI
WHERE
    DC.HospitalID = THI.HospitalID
    AND DC.DepartmentID = 1; -- Replace 6 with the specific DepartmentID you want to focus on


--Cost analysis of Treatments in Departments

select Treatment.Cost, Treatment.Name , Treatment.Description , Treatment.Duration from Treatment join Department on Treatment.DepartmentID = Department.DepartmentID where Department.DepartmentID = 10;

--Patients in dept over years

select count(Patient.PatientID) as PatientCount , Appointment.AppointmentDate
from  Patient join Appointment on Patient.PatientID = Appointment.PatientID 
join DoctorDepartmentAssignment on Appointment.DoctorID = DoctorDepartmentAssignment.DoctorID 
join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
join Hospital on Hospital.HospitalID = Department.HospitalID join Person on Patient.PatientID = Person.UserID
join Users on Users.UserID = Person.UserID where  department.DepartmentID = 10 group by Appointment.AppointmentDate;



--Earning Report of this department

SELECT Department.DepartmentID , Department.Name, Department.HospitalID , sum(Invoice.TotalAmount) as TotalAmountInDeptGain , Invoice.DateIssued
FROM Department join DoctorDepartmentAssignment on DoctorDepartmentAssignment.DepartmentID = Department.DepartmentID join Doctor on Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID join Appointment on Appointment.DoctorID = Doctor.DoctorID join patient on Patient.PatientID = Appointment.PatientID join PatientSymptoms on PatientSymptoms.PatientID = Patient.PatientID join Prescription on Prescription.SymptomID = PatientSymptoms.SymptomID join Invoice on Invoice.InvoiceID = Prescription.PrescriptionID
WHERE Department.HospitalID = (
    SELECT HospitalID
    FROM Department
    WHERE DepartmentID = 6 
) and Department.DepartmentID = 6  group by Department.Name ,Department.HospitalID ,Department.DepartmentID , Invoice.DateIssued;