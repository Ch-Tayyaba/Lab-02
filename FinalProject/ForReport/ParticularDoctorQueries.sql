--Doctor Info 

select  Person.FirstName , Person.LastName , Person.Contact , person.Email , doctor.ConsultationFee , doctor.Experience , doctor.LicenceNumber , doctor.Qualification , doctor.Specialization , Hospital.Name , Department.Name from Doctor join Person on Doctor.DoctorID = Person.UserID join Users on Users.UserID = Person.UserID  join DoctorDepartmentAssignment on Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID where Doctor.DoctorID = 55

--Earning Report

select sum(Invoice.TotalAmount) as Earning , Invoice.DateIssued from Doctor join Person on Doctor.DoctorID = Person.UserID join Users on Users.UserID = Person.UserID  join DoctorDepartmentAssignment on Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID join Appointment on Appointment.DoctorID = Doctor.DoctorID join Prescription on Prescription.DoctorID = Appointment.DoctorID join Invoice on Invoice.InvoiceID = Prescription.PrescriptionID where Doctor.DoctorID = 400 group by  Invoice.DateIssued


--Total Appointments

SELECT COUNT(P.PatientID) AS TotalPatients, A.AppointmentDate
FROM Doctor AS D
JOIN Person AS Per ON D.DoctorID = Per.UserID
JOIN Users AS U ON U.UserID = Per.UserID
JOIN DoctorDepartmentAssignment AS DDA ON D.DoctorID = DDA.DoctorID
JOIN Department AS Dept ON Dept.DepartmentID = DDA.DepartmentID
JOIN Hospital AS H ON H.HospitalID = Dept.HospitalID
JOIN Appointment AS A ON A.DoctorID = D.DoctorID
JOIN Patient AS P ON A.PatientID = P.PatientID
JOIN PatientSymptoms AS PS ON P.PatientID = PS.PatientID
JOIN Prescription AS Pr ON Pr.SymptomID = PS.SymptomID
JOIN Invoice AS I ON I.InvoiceID = Pr.PrescriptionID
WHERE D.DoctorID = 400
GROUP BY A.AppointmentDate;

--Cases by Doctor
	SELECT
    D.DoctorID,
    SUM(CASE WHEN Pr.CaseType = 11 THEN 1 ELSE 0 END) AS Routine,
    SUM(CASE WHEN Pr.CaseType = 12 THEN 1 ELSE 0 END) AS Mild,
    SUM(CASE WHEN Pr.CaseType = 13 THEN 1 ELSE 0 END) AS Critical
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
JOIN
    Invoice AS I ON I.InvoiceID = Pr.PrescriptionID
WHERE
    D.DoctorID = 400
GROUP BY
    D.DoctorID














--Treatments given by doctor
SELECT
    D.DoctorID,
    P.PatientID,
    A.AppointmentID,
    A.AppointmentDate,
    Pr.PrescriptionID,
	Pr.Diagnosis,
	Pr.Advice,
    Pr.TreatmentPlan,
    I.InvoiceID,
    I.PaymentStatus
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
JOIN
    Invoice AS I ON I.InvoiceID = Pr.PrescriptionID
WHERE
    D.DoctorID = 400; 

--All patients treated by doctor


SELECT
    PeS.FirstName,
    PS.SymptomName
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

--Doctor Contribution

WITH DoctorContribution AS (
    SELECT
        D.DoctorID,
        Per.FirstName,
        Per.LastName,
        SUM(I.TotalAmount) AS TotalAmountByDoctor,
        D.HospitalID
    FROM
        Doctor AS D
    JOIN
        Person AS Per ON D.DoctorID = Per.UserID
    JOIN
        DoctorDepartmentAssignment AS DDA ON D.DoctorID = DDA.DoctorID
    JOIN
        Appointment AS A ON A.DoctorID = D.DoctorID
    JOIN
        Patient AS P ON P.PatientID = A.PatientID
    JOIN
        PatientSymptoms AS PS ON PS.PatientID = P.PatientID
    JOIN
        Prescription AS Pr ON Pr.SymptomID = PS.SymptomID
    JOIN
        Invoice AS I ON I.InvoiceID = Pr.PrescriptionID
    WHERE
        D.HospitalID = (
            SELECT HospitalID
            FROM Doctor
            WHERE DoctorID = 400 -- Replace with the user's provided DoctorID
        )
    GROUP BY
        D.DoctorID,
        Per.FirstName,
        Per.LastName,
        D.HospitalID
),
TotalHospitalInvoice AS (
    SELECT
        SUM(I.TotalAmount) AS TotalHospitalAmount,
        D.HospitalID
    FROM
        Doctor AS D
    JOIN
        DoctorDepartmentAssignment AS DDA ON D.DoctorID = DDA.DoctorID
    JOIN
        Appointment AS A ON A.DoctorID = D.DoctorID
    JOIN
        Patient AS P ON P.PatientID = A.PatientID
    JOIN
        PatientSymptoms AS PS ON PS.PatientID = P.PatientID
    JOIN
        Prescription AS Pr ON Pr.SymptomID = PS.SymptomID
    JOIN
        Invoice AS I ON I.InvoiceID = Pr.PrescriptionID
    WHERE
        D.HospitalID = (
            SELECT HospitalID
            FROM Doctor
            WHERE DoctorID = 400 -- Replace with the user's provided DoctorID
        )
    GROUP BY
        D.HospitalID
)
SELECT
    DC.DoctorID,
    CONCAT(DC.FirstName, ' ', DC.LastName) AS DoctorName,
    DC.TotalAmountByDoctor AS DoctorTotal,
    (DC.TotalAmountByDoctor * 100.0) / THI.TotalHospitalAmount AS ContributionPercentage,
    100 - ((DC.TotalAmountByDoctor * 100.0) / THI.TotalHospitalAmount) AS OtherContribution
FROM
    DoctorContribution DC
    CROSS JOIN TotalHospitalInvoice THI
WHERE
    DC.HospitalID = THI.HospitalID
    AND DC.DoctorID = 400; -- Replace with the specific DoctorID you want to focus on
