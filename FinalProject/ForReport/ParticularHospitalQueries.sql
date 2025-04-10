 --Female Patient Count 
select count(Patient.PatientID) as FemalePatientCount
from  Patient join Appointment on Patient.PatientID = Appointment.PatientID 
join DoctorDepartmentAssignment on Appointment.DoctorID = DoctorDepartmentAssignment.DoctorID 
join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
join Hospital on Hospital.HospitalID = Department.HospitalID join Person on Patient.PatientID = Person.UserID
join Users on Users.UserID = Person.UserID where Person.Gender = 6 and Hospital.HospitalID = 10


--Total Patients of that Hospital
select count(Patient.PatientID) as PatientCount
from  Patient join Appointment on Patient.PatientID = Appointment.PatientID 
join DoctorDepartmentAssignment on Appointment.DoctorID = DoctorDepartmentAssignment.DoctorID 
join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
join Hospital on Hospital.HospitalID = Department.HospitalID where Hospital.HospitalID = 10


-- Particular Hospital (which department has the most Invoice Id's (famous))
select count(Invoice.InvoiceID) as InvoiceCount , Department.DepartmentID from Invoice join Prescription on Prescription.PrescriptionID = Invoice.InvoiceID join Doctor on Doctor.DoctorID = Prescription.DoctorID join DoctorDepartmentAssignment on Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID where Hospital.HospitalID = 4 group by Department.DepartmentID;

--A particular Hospital Contribution to the whole system

select count(Patient.PatientID) as Patientcount , Hospital.HospitalID from Patient join Appointment on Patient.PatientID = Appointment.PatientID join Doctor on Appointment.DoctorID = Doctor.DoctorID join DoctorDepartmentAssignment on DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID  join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID  group by Hospital.HospitalID  order by HospitalID

SELECT ISNULL(COUNT(Patient.PatientID), 0) AS PatientCount, Hospital.HospitalID
FROM Hospital
LEFT JOIN Department ON Hospital.HospitalID = Department.HospitalID
LEFT JOIN DoctorDepartmentAssignment ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
LEFT JOIN Doctor ON DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID
LEFT JOIN Appointment ON Doctor.DoctorID = Appointment.DoctorID
LEFT JOIN Patient ON Appointment.PatientID = Patient.PatientID
GROUP BY Hospital.HospitalID
ORDER BY Hospital.HospitalID;


WITH HospitalPatientCount AS (
    SELECT
        ISNULL(COUNT(Patient.PatientID), 0) AS PatientCount,
        Hospital.HospitalID
    FROM
        Hospital
        LEFT JOIN Department ON Hospital.HospitalID = Department.HospitalID
        LEFT JOIN DoctorDepartmentAssignment ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
        LEFT JOIN Doctor ON DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID
        LEFT JOIN Appointment ON Doctor.DoctorID = Appointment.DoctorID
        LEFT JOIN Patient ON Appointment.PatientID = Patient.PatientID
    GROUP BY
        Hospital.HospitalID
),
TotalPatients AS (
    SELECT SUM(PatientCount) AS TotalCount FROM HospitalPatientCount
)
SELECT
    HPC.PatientCount,
    HPC.HospitalID,
    (HPC.PatientCount * 100.0) / TP.TotalCount AS ContributionPercentage
FROM
    HospitalPatientCount HPC
    CROSS JOIN TotalPatients TP
WHERE
    HPC.HospitalID = 8; 

	WITH HospitalPatientCount AS (  --Includes other contribution too
    SELECT
        ISNULL(COUNT(Patient.PatientID), 0) AS PatientCount,
        Hospital.HospitalID
    FROM
        Hospital
        LEFT JOIN Department ON Hospital.HospitalID = Department.HospitalID
        LEFT JOIN DoctorDepartmentAssignment ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
        LEFT JOIN Doctor ON DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID
        LEFT JOIN Appointment ON Doctor.DoctorID = Appointment.DoctorID
        LEFT JOIN Patient ON Appointment.PatientID = Patient.PatientID
    GROUP BY
        Hospital.HospitalID
),
TotalPatients AS (
    SELECT SUM(PatientCount) AS TotalCount FROM HospitalPatientCount
),
SelectedHospital AS (
    SELECT
        HPC.PatientCount,
        HPC.HospitalID,
        (HPC.PatientCount * 100.0) / TP.TotalCount AS ContributionPercentage
    FROM
        HospitalPatientCount HPC
        CROSS JOIN TotalPatients TP
    WHERE
        HPC.HospitalID = 8 -- Specify the HospitalID you want to focus on here
)
SELECT
    SH.PatientCount,
    SH.HospitalID,
    SH.ContributionPercentage,
    100 - SH.ContributionPercentage AS OtherContribution
FROM
    SelectedHospital SH;

--Famous Doctor of a Hospital
select Person.FirstName , count(Appointment.AppointmentID) as TotatAppintments from Doctor join Appointment on Doctor.DoctorID = Appointment.DoctorID join DoctorDepartmentAssignment on Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID join Person on Person.UserID = Doctor.DoctorID where Hospital.HospitalID = 4 group by Person.FirstName;

--Case types in Hospital
select Prescription.CaseType from Prescription join Doctor on Doctor.DoctorID = Prescription.DoctorID join DoctorDepartmentAssignment on DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID where Hospital.HospitalID = 4;

	SELECT
    SUM(CASE WHEN Prescription.CaseType = 11 THEN 1 ELSE 0 END) AS Routine,
    SUM(CASE WHEN Prescription.CaseType = 12 THEN 1 ELSE 0 END) AS Mild,
    SUM(CASE WHEN Prescription.CaseType = 13 THEN 1 ELSE 0 END) AS Critical
FROM
    Prescription
JOIN
    Doctor ON Doctor.DoctorID = Prescription.DoctorID
JOIN
    DoctorDepartmentAssignment ON DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID
JOIN
    Department ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
JOIN
    Hospital ON Hospital.HospitalID = Department.HospitalID
WHERE
    Hospital.HospitalID = 4;


--How many doctors a department has?
select count(Doctor.DoctorID) as TotalDoctors , Department.Name from Doctor join DoctorDepartmentAssignment on DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID  = Department.HospitalID where Hospital.HospitalID = 4 group by Department.Name;

--How many doctors are free or busy in a hospital

select Doctor.CheckupStatus from Doctor join DoctorDepartmentAssignment on  Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID where Hospital.HospitalID = 4;

SELECT
    SUM(CASE WHEN Doctor.CheckupStatus = 7 THEN 1 ELSE 0 END) AS Busy,
    SUM(CASE WHEN Doctor.CheckupStatus = 8 THEN 1 ELSE 0 END) AS Free,
    COUNT(Doctor.DoctorID) AS TotalDoctors
FROM
    Doctor
JOIN
    DoctorDepartmentAssignment ON Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID
JOIN
    Department ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
JOIN
    Hospital ON Hospital.HospitalID = Department.HospitalID
WHERE
    Hospital.HospitalID = 18;
	
--Total doctors in a Hospital
select count(Doctor.DoctorID)as TotalDoctors from Doctor join DoctorDepartmentAssignment on Doctor.DoctorID  = DoctorDepartmentAssignment.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID where Hospital.HospitalID = 5;

--Male doctors in Hospital
select count(Doctor.DoctorID)as MaleDoctors from Doctor join DoctorDepartmentAssignment on Doctor.DoctorID  = DoctorDepartmentAssignment.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID  join person on person.UserID = Doctor.DoctorID join Users on Users.UserID = Person.UserID where Hospital.HospitalID = 5 and Person.Gender = 5;

--Female Doctors in Hospital
select count(Doctor.DoctorID)as FemaleDoctors from Doctor join DoctorDepartmentAssignment on Doctor.DoctorID  = DoctorDepartmentAssignment.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID  join person on person.UserID = Doctor.DoctorID join Users on Users.UserID = Person.UserID where Hospital.HospitalID = 5 and Person.Gender = 6;

--treatments in every department in a hospital
select count(Treatment.TreatmentID) as TotalTreatments , Department.Name as DepartmentName from Treatment join Department on Treatment.DepartmentID = Department.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID where Hospital.HospitalID = 4 group by Department.Name;

--Earning Report of a Hospital

select sum(Invoice.TotalAmount) as Earning , month(invoice.DateIssued) as Month from Invoice join Prescription on Invoice.InvoiceID = Prescription.PrescriptionID join Doctor on Doctor.DoctorID = Prescription.DoctorID  join DoctorDepartmentAssignment on Doctor.DoctorID  = DoctorDepartmentAssignment.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID where Hospital.HospitalID = 9 group by month(invoice.DateIssued);


