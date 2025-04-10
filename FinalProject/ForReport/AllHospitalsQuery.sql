--Most Famous Hospitals

select hospital.Name , sum(Invoice.TotalAmount) as Earning from hospital join Department on Hospital.HospitalID = Department.HospitalID join DoctorDepartmentAssignment on DoctorDepartmentAssignment.DepartmentID = department.DepartmentID join Doctor on Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID join Prescription on Prescription.DoctorID = Doctor.DoctorID join Invoice on Invoice.InvoiceID = Prescription.PrescriptionID group by Hospital.Name order by sum(Invoice.TotalAmount)

--Famous Doctors

select top 15 Person.FirstName , sum(Invoice.TotalAmount) as Earning from hospital join Department on Hospital.HospitalID = Department.HospitalID join DoctorDepartmentAssignment on DoctorDepartmentAssignment.DepartmentID = department.DepartmentID join Doctor on Doctor.DoctorID = DoctorDepartmentAssignment.DoctorID join Prescription on Prescription.DoctorID = Doctor.DoctorID join Invoice on Invoice.InvoiceID = Prescription.PrescriptionID join person on Person.UserID = Doctor.DoctorID join Users on Users.UserID = Person.UserID group by Person.FirstName order by sum(Invoice.TotalAmount) desc

--Patients visit

select Hospital.Name , count(Appointment.AppointmentID) as PatientVisits from Person join Users on Users.UserId = Person.UserID join Patient on Patient.PatientID = Person.UserID join Appointment on Appointment.PatientID = Patient.PatientID join Doctor on Doctor.DoctorID = Appointment.DoctorID join DoctorDepartmentAssignment on DoctorDepartmentAssignment.DoctorID = Doctor.DoctorID join Department on Department.DepartmentID = DoctorDepartmentAssignment.DepartmentID join Hospital on Hospital.HospitalID = Department.HospitalID group by Hospital.Name