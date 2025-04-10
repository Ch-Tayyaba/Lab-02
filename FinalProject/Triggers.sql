-- AdminLog table
CREATE TABLE AdminLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    AdminID INT,
    Action VARCHAR(20),
    Timestamp DATETIME
);

-- AppointmentLog table
CREATE TABLE AppointmentLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    AppointmentID INT,
    Action VARCHAR(20),
    Timestamp DATETIME
);

-- DepartmentLog table
CREATE TABLE DepartmentLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentID INT,
    Action VARCHAR(20),
    Timestamp DATETIME
);

-- HospitalLog table
CREATE TABLE HospitalLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    HospitalID INT,
    Action VARCHAR(20),
    Timestamp DATETIME
);
-- AdminLog table
CREATE TABLE AdminLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    AdminID INT,
    Action VARCHAR(20),
    Timestamp DATETIME
);

-- AppointmentLog table
CREATE TABLE AppointmentLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    AppointmentID INT,
    Action VARCHAR(20),
    Timestamp DATETIME
);

-- DepartmentLog table
CREATE TABLE DepartmentLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentID INT,
    Action VARCHAR(20),
    Timestamp DATETIME
);

-- HospitalLog table
CREATE TABLE HospitalLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    HospitalID INT,
    Action VARCHAR(20),
    Timestamp DATETIME
);




CREATE TRIGGER trg_Admin_InsertUpdateDelete
ON dbo.Admin
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO AdminLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO AdminLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Triggers for Appointment table
CREATE TRIGGER trg_Appointment_InsertUpdateDelete
ON dbo.Appointment
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO AppointmentLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO AppointmentLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO
-- Trigger for Doctor table
CREATE TRIGGER trg_Doctor_InsertUpdateDelete
ON dbo.Doctor
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO DoctorLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO DoctorLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for Department table
CREATE TRIGGER trg_Department_InsertUpdateDelete
ON dbo.Department
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO DepartmentLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO DepartmentLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for Hospital table
CREATE TRIGGER trg_Hospital_InsertUpdateDelete
ON dbo.Hospital
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO HospitalLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO HospitalLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for Invoice table
CREATE TRIGGER trg_Invoice_InsertUpdateDelete
ON dbo.Invoice
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO InvoiceLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO InvoiceLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for Lookup table
CREATE TRIGGER trg_Lookup_InsertUpdateDelete
ON dbo.Lookup
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO LookupLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO LookupLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for Medicine table
CREATE TRIGGER trg_Medicine_InsertUpdateDelete
ON dbo.Medicine
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO MedicineLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO MedicineLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for Patient table
CREATE TRIGGER trg_Patient_InsertUpdateDelete
ON dbo.Patient
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO PatientLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO PatientLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for PatientMedicine table
CREATE TRIGGER trg_PatientMedicine_InsertUpdateDelete
ON dbo.PatientMedicine
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO PatientMedicineLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO PatientMedicineLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO


-- Trigger for PatientSymptoms table
CREATE TRIGGER trg_PatientSymptoms_InsertUpdateDelete
ON dbo.PatientSymptoms
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO PatientSymptomsLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO PatientSymptomsLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for Person table
CREATE TRIGGER trg_Person_InsertUpdateDelete
ON dbo.Person
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO PersonLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO PersonLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for Prescription table
CREATE TRIGGER trg_Prescription_InsertUpdateDelete
ON dbo.Prescription
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO PrescriptionLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO PrescriptionLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for Treatment table
CREATE TRIGGER trg_Treatment_InsertUpdateDelete
ON dbo.Treatment
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO TreatmentLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO TreatmentLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO

-- Trigger for Users table
CREATE TRIGGER trg_Users_InsertUpdateDelete
ON dbo.Users
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Log changes
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO UsersLog (Action, Timestamp)
        VALUES ('INSERT/UPDATE', GETDATE());
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO UsersLog (Action, Timestamp)
        VALUES ('DELETE', GETDATE());
    END
END;
GO






-- Inserting a record into the PatientMedicine table
INSERT INTO PatientMedicine (MedicineID, PrescriptionID, DosageTime, DosageDuration, DosageQuantity)
VALUES (1, 1, 'Morning', '2024-05-12', 1);

-- Updating a record in the PatientSymptoms table
UPDATE PatientSymptoms
SET SymptomName = 'Headache'
WHERE SymptomID = 1;

-- Deleting a record from the Person table
DELETE FROM Person
WHERE UserID = 1001;

