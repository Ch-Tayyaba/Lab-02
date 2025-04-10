--All hospitals by earnings:
SELECT H.Name AS HospitalName, H.Location AS HospitalLocation, SUM(I.TotalAmount) AS TotalEarnings, COUNT(DISTINCT P.PatientID) AS TotalPatients, COUNT(DISTINCT D.DoctorID) AS TotalDoctors, AVG(I.TotalAmount) AS AverageEarnings, MAX(I.TotalAmount) AS MaxEarnings, MIN(I.TotalAmount) AS MinEarnings FROM Hospital H LEFT JOIN Patient P ON H.HospitalID = P.HospitalID LEFT JOIN Appointment A ON P.PatientID = A.PatientID LEFT JOIN Doctor D ON A.DoctorID = D.DoctorID LEFT JOIN Invoice I ON A.AppointmentID = I.InvoiceID GROUP BY H.Name, H.Location ORDER BY TotalEarnings DESC;

--All doctors with their earnings:
SELECT P.FirstName, P.LastName, D.Qualification, D.Specialization, D.Experience, D.ConsultationFee, SUM(I.TotalAmount) AS TotalEarnings, COUNT(DISTINCT A.AppointmentID) AS TotalAppointments, AVG(I.TotalAmount) AS AverageEarnings, MAX(I.TotalAmount) AS MaxEarnings, MIN(I.TotalAmount) AS MinEarnings 
FROM Doctor D 
INNER JOIN Person P ON D.DoctorID = P.UserID 
LEFT JOIN Appointment A ON D.DoctorID = A.DoctorID 
LEFT JOIN Invoice I ON A.AppointmentID = I.InvoiceID 
GROUP BY D.DoctorID, P.FirstName, P.LastName, D.Qualification, D.Specialization, D.Experience, D.ConsultationFee 
ORDER BY TotalEarnings DESC;

SELECT P.FirstName, P.LastName, D.Qualification, D.Specialization, D.Experience, D.ConsultationFee, SUM(I.TotalAmount) AS TotalEarnings, COUNT(DISTINCT A.AppointmentID) AS TotalAppointments, AVG(I.TotalAmount) AS AverageEarnings, MAX(I.TotalAmount) AS MaxEarnings, MIN(I.TotalAmount) AS MinEarnings FROM Doctor D INNER JOIN Person P ON D.DoctorID = P.UserID LEFT JOIN Appointment A ON D.DoctorID = A.DoctorID LEFT JOIN Invoice I ON A.AppointmentID = I.InvoiceID GROUP BY D.DoctorID, P.FirstName, P.LastName, D.Qualification, D.Specialization, D.Experience, D.ConsultationFee ORDER BY TotalEarnings DESC;


--Count of patient visits in every hospital:
SELECT 
    H.Name AS HospitalName, 
    H.Location AS HospitalLocation, 
    H.Website AS HospitalWebsite, 
    H.Email AS HospitalEmail, 
    H.Contact AS HospitalContact, 
    P.FirstName AS AdminFirstName, 
    P.LastName AS AdminLastName, 
    COUNT(DISTINCT Pa.PatientID) AS TotalVisits 
FROM 
    Hospital H 
LEFT JOIN 
    Admin A ON H.AdminID = A.AdminID 
LEFT JOIN 
    Person P ON A.AdminID = P.UserID 
LEFT JOIN 
    Patient Pa ON H.HospitalID = Pa.HospitalID 
GROUP BY 
    H.Name, 
    H.Location, 
    H.Website, 
    H.Email, 
    H.Contact, 
    P.FirstName, 
    P.LastName 
ORDER BY 
    TotalVisits DESC;


--Overall hospitals in all cities of Pakistan:
SELECT 
    H.Name AS HospitalName,
    H.Location,
    H.State, 
    H.City, 
    COUNT(H.HospitalID) AS TotalHospitals 
FROM 
    Hospital H 
GROUP BY 
    H.Name,
    H.State, 
    H.City,
    H.Location;


--Popular diseases of all hospitals:
WITH PopularDiseases AS (
    SELECT 
        H.Name AS HospitalName, 
        PS.SymptomName AS PopularDisease, 
        COUNT(PS.SymptomID) AS DiseaseCount,
        ROW_NUMBER() OVER (PARTITION BY H.Name ORDER BY COUNT(PS.SymptomID) DESC) AS DiseaseRank
    FROM 
        Hospital H 
    LEFT JOIN 
        Patient P ON H.HospitalID = P.HospitalID 
    LEFT JOIN 
        PatientSymptoms PS ON P.PatientID = PS.PatientID 
    GROUP BY 
        H.Name, 
        PS.SymptomName
)
SELECT 
    HospitalName, 
    PopularDisease, 
    DiseaseCount
FROM 
    PopularDiseases
WHERE 
    DiseaseRank <= 5
ORDER BY 
    HospitalName, 
    DiseaseCount DESC;
