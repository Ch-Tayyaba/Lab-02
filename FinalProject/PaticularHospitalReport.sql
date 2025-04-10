-- Particular Hospital (which department has the most Invoice Id's (famous))
SELECT
    Department.Name AS DepartmentName,
	COUNT(Invoice.InvoiceID) AS InvoiceCount,
    (SELECT Top 1 Location FROM Department AS D WHERE D.Name = Department.Name) AS DepartmentLocation,
    (SELECT Top 1 Contact FROM Department AS D WHERE D.Name = Department.Name) AS DepartmentContact,
	Hospital.HospitalID
FROM
    Invoice
JOIN
    Prescription ON Prescription.PrescriptionID = Invoice.InvoiceID
JOIN
    Doctor ON Doctor.DoctorID = Prescription.DoctorID
JOIN
    DoctorDepartmentAssignment ON Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID
JOIN
    Department ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
JOIN
    Hospital ON Hospital.HospitalID = Department.HospitalID
WHERE
    Hospital.HospitalID = 4
GROUP BY
    Department.Name,Hospital.HospitalID;



--Every Hospital Contribution to the whole system
SELECT
    Hospital.Name AS HospitalName,
	COUNT(Patient.PatientID) AS PatientCount,
    Hospital.State AS HospitalState,
	Hospital.City AS HospitalCity,
	Hospital.ZipCode AS HospitalZipcode,
    Hospital.Contact AS HospitalContact,
    Hospital.Website AS HospitalWebsite,
    Hospital.Email AS HospitalEmail
FROM
    Patient
JOIN
    Appointment ON Patient.PatientID = Appointment.PatientID
JOIN
    Doctor ON Appointment.DoctorID = Doctor.DoctorID
JOIN
    DoctorDepartmentAssignment ON DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID
JOIN
    Department ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
JOIN
    Hospital ON Hospital.HospitalID = Department.HospitalID
GROUP BY
    Hospital.HospitalID, Hospital.Name, Hospital.State,Hospital.City,Hospital.ZipCode, Hospital.Contact, Hospital.Website, Hospital.Email
ORDER BY
    PatientCount;



--Famous Doctor of a Hospital
SELECT
    Person.FirstName + ' ' +Person.LastName as Name,
	COUNT(Appointment.AppointmentID) AS TotalAppointments,
    Department.Name AS DepartmentName,
    Person.Address,
    Person.CNIC,
    Person.Contact AS DoctorContact,
    Person.Email AS DoctorEmail,
    Person.DateOfBirth,
    Doctor.Qualification,
    Doctor.Specialization,
    Doctor.Experience,
	Hospital.HospitalID    
FROM
    Doctor
JOIN
    Appointment ON Doctor.DoctorID = Appointment.DoctorID
JOIN
    DoctorDepartmentAssignment ON Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID
JOIN
    Department ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
JOIN
    Hospital ON Hospital.HospitalID = Department.HospitalID
JOIN
    Person ON Person.UserID = Doctor.DoctorID
WHERE
    Hospital.HospitalID = 4
GROUP BY
    Person.FirstName, Person.LastName, Person.Gender, Person.Address, Person.CNIC, Person.Contact, Person.Email, Person.DateOfBirth,
    Doctor.Qualification, Doctor.Specialization, Doctor.Experience,
    Hospital.Name, Hospital.Location, Hospital.Contact,
    Department.Name,Hospital.HospitalID
ORDER BY 
    TotalAppointments DESC;



--Case types Count in Hospital
SELECT
	Hospital.Name AS HospitalName,
    Prescription.CaseType,
    COUNT(Prescription.CaseType) AS CaseTypeCount,
    Hospital.Location AS HospitalLocation,
    Hospital.Contact AS HospitalContact,
	Hospital.HospitalID
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
    Hospital.HospitalID = 4
GROUP BY
    Prescription.CaseType, Hospital.Name, Hospital.Location, Hospital.Contact,Hospital.HospitalID;



--How many doctors a department has?
SELECT
	Department.Name AS DepartmentName,
    COUNT(Doctor.DoctorID) AS TotalDoctors,
    (SELECT Top 1 Location FROM Department AS D WHERE D.Name = Department.Name) AS DepartmentLocation,
    (SELECT Top 1 Contact FROM Department AS D WHERE D.Name = Department.Name) AS DepartmentContact,
    Hospital.HospitalID
FROM
    Doctor
JOIN
    DoctorDepartmentAssignment ON Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID
JOIN
    Department ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
JOIN
    Hospital ON Hospital.HospitalID = Department.HospitalID
WHERE
    Hospital.HospitalID = 4
GROUP BY
    Department.Name, Hospital.HospitalID;


--treatments in every department in a hospital
SELECT
    Department.Name AS DepartmentName,
	COUNT(Treatment.TreatmentID) AS TotalTreatments,
    (SELECT Top 1 Location FROM Department AS D WHERE D.Name = Department.Name) AS DepartmentLocation,
    (SELECT Top 1 Contact FROM Department AS D WHERE D.Name = Department.Name) AS DepartmentContact,
    Hospital.HospitalID
FROM
    Treatment
JOIN
    Department ON Treatment.DepartmentID = Department.DepartmentID
JOIN
    Hospital ON Hospital.HospitalID = Department.HospitalID
WHERE
    Hospital.HospitalID = 4
GROUP BY
    Department.Name, Hospital.HospitalID;


--Earning Report of a Hospital
SELECT
    SUM(Invoice.TotalAmount) AS Earning,
    MONTH(Invoice.DateIssued) AS Month,
	DATENAME(MONTH, Invoice.DateIssued) AS MonthName,
	Hospital.HospitalID,
	Hospital.Name
FROM
    Invoice
JOIN
    Prescription ON Invoice.InvoiceID = Prescription.PrescriptionID
JOIN
    Doctor ON Doctor.DoctorID = Prescription.DoctorID
JOIN
    DoctorDepartmentAssignment ON Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID
JOIN
    Department ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
JOIN
    Hospital ON Hospital.HospitalID = Department.HospitalID
WHERE
    Hospital.HospitalID = 9
GROUP BY
    MONTH(Invoice.DateIssued), Hospital.HospitalID,DATENAME(MONTH, Invoice.DateIssued),Hospital.Name
Order By 
	Month;




