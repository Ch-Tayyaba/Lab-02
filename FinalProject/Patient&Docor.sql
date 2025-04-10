
--patient has been diagnosed with

select  PatientSymptoms.SymptomName , Prescription.Diagnosis ,Prescription.TreatmentPlan , Prescription.Advice,Patient.PatientID, p.FirstName from Prescription join PatientSymptoms on Prescription.SymptomID = PatientSymptoms.SymptomID join patient on Patient.PatientID = PatientSymptoms.PatientID join person p on p.UserID = Patient.PatientID where Patient.PatientID = 1050

--Patient has Visited which Departments
select Department.Name , count(Department.DepartmentID) as VisitCount from Patient join PatientSymptoms on PatientSymptoms.PatientID = Patient.PatientID join Prescription on PatientSymptoms.SymptomID = Prescription.SymptomID join Doctor on Doctor.DoctorID = Prescription.DoctorID join DoctorDepartmentAssignment on DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID where Patient.PatientID = 1015 group by Department.Name;

SELECT
	Hospital.Name AS HospitalName,
    Hospital.Location AS HospitalLocation,
    Hospital.Website AS HospitalWebsite,
    Hospital.Email AS HospitalEmail,
    Hospital.Contact AS HospitalContact,
    Department.Name AS DepartmentName,
    Department.Location AS DepartmentLocation,
    Department.Contact AS DepartmentContact,
    COUNT(Department.DepartmentID) AS VisitCount,
	Patient.PatientID
FROM
    Patient
JOIN
    PatientSymptoms ON PatientSymptoms.PatientID = Patient.PatientID
JOIN
    Prescription ON PatientSymptoms.SymptomID = Prescription.SymptomID
JOIN
    Doctor ON Doctor.DoctorID = Prescription.DoctorID
JOIN
    DoctorDepartmentAssignment ON DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID
JOIN
    Department ON Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID
JOIN
    Hospital ON Hospital.HospitalID = Department.HospitalID
WHERE
    Patient.PatientID = 1015
GROUP BY
    Department.Name,
    Department.Location,
    Department.Contact,
    Hospital.Name,
    Hospital.Location,
    Hospital.Website,
    Hospital.Email,
    Hospital.Contact,
	Patient.PatientID;






--Patient Symptoms over the Year
select SymptomName , month(DateRecorded) as Months from PatientSymptoms where PatientID = 903  order by YEAR(DateRecorded);

 SELECT SymptomName, CONCAT(MONTH(DateRecorded), '/', YEAR(DateRecorded)) AS MonthYear , month(DateRecorded) as Months
FROM PatientSymptoms
WHERE PatientID = 817 order by YEAR(DateRecorded);

SELECT
    SymptomName,
    CONCAT(DATENAME(MONTH, DateRecorded), '/', YEAR(DateRecorded)) AS MonthYear,
    DATENAME(MONTH, DateRecorded) AS MonthName,
    MONTH(DateRecorded) AS MonthNumber,
	PatientID

FROM
    PatientSymptoms
WHERE
    PatientID = 817
ORDER BY
    YEAR(DateRecorded), MONTH(DateRecorded);





--Patient's Appointment Schedule:
SELECT  
       
       (SELECT CONCAT(FirstName, ' ', LastName) FROM Person WHERE UserID = A.PatientID) AS PatientName,
	   A.AppointmentDate, 
       (SELECT CONCAT(FirstName, ' ', LastName) FROM Person WHERE UserID = D.DoctorID) AS DoctorName,
       D.Qualification, 
       D.Specialization,
	   A.PatientID
FROM Appointment A
JOIN Doctor D ON A.DoctorID = D.DoctorID
WHERE A.PatientID = 1050;


--Patient's Invoice Details:
SELECT Invoice.InvoiceID, Invoice.TotalAmount, Invoice.PaymentStatus, Invoice.DateIssued,PatientSymptoms.PatientID, p.FirstName
FROM Invoice
JOIN Prescription ON Invoice.InvoiceID= Prescription.PrescriptionID
join PatientSymptoms on PatientSymptoms.SymptomID = Prescription.SymptomID
join Patient on Patient.PatientID = PatientSymptoms.PatientID
join person p on p.UserID = Patient.PatientID
WHERE Patient.PatientID = 1000;

--Patient's Prescription History and Corresponding Medications:
SELECT 
Prescription.PrescriptionID,  Prescription.Diagnosis,Prescription.DateStarted,
(SELECT COUNT(*) FROM PatientMedicine WHERE PatientMedicine.PrescriptionID = Prescription.PrescriptionID) AS MedicationCount,
 (SELECT CONCAT(FirstName, ' ', LastName) FROM Person WHERE UserID = PatientSymptoms.PatientID) AS PatientName,PatientSymptoms.PatientID
FROM Prescription
join PatientSymptoms on PatientSymptoms.SymptomID = Prescription.SymptomID
join Patient on Patient.PatientID = PatientSymptoms.PatientID
WHERE PatientSymptoms.PatientID = 1000;





select * from Users where Role = 4
select * from Lookup






----------------------------------------DOCTOR-------------------------------------



--Treatment Diagnosis given by doctor
SELECT
	Pr.PrescriptionID,
	(SELECT CONCAT(FirstName, ' ', LastName) FROM Person WHERE UserID = A.PatientID) AS PatientName,
    A.AppointmentDate,
	Pr.Diagnosis,
	Pr.Advice,
    Pr.TreatmentPlan,
	(SELECT CONCAT(FirstName, ' ', LastName) FROM Person WHERE UserID = D.DoctorID) AS DoctorName,
	D.DoctorID
FROM
    Doctor AS D
JOIN
    Person AS Per ON D.DoctorID = Per.UserID
JOIN
    Users AS U ON U.UserID = Per.UserID
JOIN
    DoctorDepartmentAssignment AS DDA ON D.DoctorID = DDA.DoctorID
JOIN
    Department AS Dept ON Dept.DepartmentID = DDA.DepartmentID
JOIN
    Hospital AS H ON H.HospitalID = Dept.HospitalID
JOIN
    Appointment AS A ON A.DoctorID = D.DoctorID
JOIN
    Patient AS P ON A.PatientID = P.PatientID
JOIN
    PatientSymptoms AS PS ON P.PatientID = PS.PatientID
JOIN
    Prescription AS Pr ON Pr.SymptomID = PS.SymptomID
WHERE
    D.DoctorID = 400; 



--All patients treated by doctor
SELECT
    PeS.FirstName as PatientName,
    PS.SymptomName,
	ps.Description,
	p.Allergies,
	PeS.DateOfBirth,
	D.DoctorID,
	(SELECT CONCAT(FirstName, ' ', LastName) FROM Person WHERE UserID = D.DoctorID) AS DoctorName
FROM
    Doctor AS D
JOIN
    Appointment AS A ON D.DoctorID = A.DoctorID
JOIN
    Patient AS P ON A.PatientID = P.PatientID
JOIN
    PatientSymptoms AS PS ON P.PatientID = PS.PatientID
JOIN
    Person AS PeS ON P.PatientID = PeS.UserID
WHERE
    D.DoctorID = 400





--Doctor's Appointment Schedule:
SELECT
	A.AppointmentID,
	(SELECT CONCAT(FirstName, ' ', LastName) FROM Person WHERE UserID = A.PatientID) AS PatientName,
    A.AppointmentDate,
    L.Value AS AppointmentStatus,
	(SELECT CONCAT(FirstName, ' ', LastName) FROM Person WHERE UserID = A.DoctorID) AS DoctorName,
	A.DoctorID
FROM
    Appointment AS A
JOIN
    Patient AS P ON A.PatientID = P.PatientID
JOIN
    Lookup AS L ON A.AppointmentStatus = L.Id
WHERE
    A.DoctorID = 60
Order By 
	A.AppointmentDate;
	


--Earned fee By month
SELECT
	MONTH(A.AppointmentDate) AS MonthNumber,
    DATENAME(MONTH, A.AppointmentDate) AS MonthName,
    SUM(D.ConsultationFee) AS TotalConsultationFeeEarned,
    A.DoctorID
FROM
    Appointment AS A
JOIN
    Doctor AS D ON D.DoctorID = A.DoctorID
WHERE
    A.DoctorID = 60
GROUP BY
    DATENAME(MONTH, A.AppointmentDate), 
    MONTH(A.AppointmentDate),
    A.DoctorID
ORDER BY
    MonthNumber;



