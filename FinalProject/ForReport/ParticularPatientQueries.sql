--Patient Info 
select concat(person.FirstName , ' ' , Person.LastName) as name , person.Email , Person.City , Patient.Weight , Patient.Height , Patient.BloodType , Patient.BloodPressure from Person join Users on Users.UserID = Person.UserID join Patient on Patient.PatientID = Users.UserID where Patient.PatientID = 554;

--Patient Symptoms over the Year
select SymptomName , month(DateRecorded) as Months from PatientSymptoms where PatientID = 903  order by YEAR(DateRecorded);

 SELECT SymptomName, CONCAT(MONTH(DateRecorded), '/', YEAR(DateRecorded)) AS MonthYear , month(DateRecorded) as Months
FROM PatientSymptoms
WHERE PatientID = 817 order by YEAR(DateRecorded);

--Patient Appointments with the doctor 
select Person.FirstName as DoctorName , Appointment.AppointmentDate from patient join Appointment on Patient.PatientID = Appointment.PatientID join Doctor on Appointment.DoctorID = Doctor.DoctorID join Person on Person.UserID = Doctor.DoctorID join Users on Users.UserID = Person.UserID where Appointment.PatientID = 1015 order by Appointment.AppointmentDate;

--how many times the case was critical mild , routine over year 

select Prescription.CaseType  from Patient Join PatientSymptoms on PatientSymptoms.PatientID = Patient.PatientID join Prescription on Prescription.SymptomID = PatientSymptoms.SymptomID where Patient.PatientID = 558 and (Prescription.CaseType = 11 or CaseType = 12 or CaseType = 13);

SELECT 
    SUM(CASE WHEN Prescription.CaseType = 11 THEN 1 ELSE 0 END) AS Routine,
    SUM(CASE WHEN Prescription.CaseType = 12 THEN 1 ELSE 0 END) AS Mild,
    SUM(CASE WHEN Prescription.CaseType = 13 THEN 1 ELSE 0 END) AS critical
FROM 
    Patient 
    JOIN PatientSymptoms ON PatientSymptoms.PatientID = Patient.PatientID 
    JOIN Prescription ON Prescription.SymptomID = PatientSymptoms.SymptomID 
WHERE 
    Patient.PatientID = 558 
    AND (Prescription.CaseType = 11 OR Prescription.CaseType = 12 OR Prescription.CaseType = 13);


--Patient bill over years

select Invoice.TotalAmount , Invoice.DateIssued from Invoice Join Prescription on Invoice.InvoiceID = Prescription.PrescriptionID join PatientSymptoms on PatientSymptoms.SymptomID = Prescription.SymptomID join Patient on Patient.PatientID = PatientSymptoms.PatientID where Patient.PatientID = 558;

--Patiest most used Medicine

select medicine.Name from PatientMedicine join Medicine on Medicine.MedicineID = PatientMedicine.MedicineID join Prescription on Prescription.PrescriptionID = PatientMedicine.PrescriptionID join PatientSymptoms on PatientSymptoms.SymptomID = Prescription.SymptomID join Patient on Patient.PatientID = PatientSymptoms.PatientID where Patient.PatientID = 560 ;





--patient has been diagnosed with

select Prescription.TreatmentPlan , Prescription.Diagnosis , PatientSymptoms.SymptomName , Prescription.Advice from Prescription join PatientSymptoms on Prescription.SymptomID = PatientSymptoms.SymptomID join patient on Patient.PatientID = PatientSymptoms.PatientID where Patient.PatientID = 1050

--Patient has Visited which Departments

select Department.Name , count(Department.DepartmentID) as VisitCount from Patient join PatientSymptoms on PatientSymptoms.PatientID = Patient.PatientID join Prescription on PatientSymptoms.SymptomID = Prescription.SymptomID join Doctor on Doctor.DoctorID = Prescription.DoctorID join DoctorDepartmentAssignment on DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID where Patient.PatientID = 1015 group by Department.Name;



--Patient Symptoms over the Year
select SymptomName , month(DateRecorded) as Months from PatientSymptoms where PatientID = 903  order by YEAR(DateRecorded);

 SELECT SymptomName, CONCAT(MONTH(DateRecorded), '/', YEAR(DateRecorded)) AS MonthYear , month(DateRecorded) as Months
FROM PatientSymptoms
WHERE PatientID = 817 order by YEAR(DateRecorded);