-- Table to store patients' information
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    birth_date DATE,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to store doctors' information
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    department_id INT,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Table to store departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);

-- Table to store appointment information
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason TEXT,
    status VARCHAR(50) DEFAULT 'Scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Table to store prescriptions
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_id INT,
    prescription_date DATE NOT NULL,
    medicine_details TEXT,
    instructions TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Table to store room allocation information
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL,
    room_type VARCHAR(50), -- e.g. Single, Double, ICU, etc.
    availability_status VARCHAR(50) DEFAULT 'Available',
    patient_id INT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Table to store billing information
CREATE TABLE Billing (
    billing_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    appointment_id INT,
    total_amount DECIMAL(10, 2),
    billing_date DATE,
    payment_status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);


INSERT INTO Departments (department_name)
VALUES 
    ('Cardiology'),
    ('Neurology'),
    ('Pediatrics'),
    ('Orthopedics'),
    ('Radiology');

INSERT INTO Doctors (first_name, last_name, specialization, department_id, phone_number, email)
VALUES 
    ('John', 'Doe', 'Cardiologist', 1, '1234567890', 'johndoe@hospital.com'),
    ('Alice', 'Smith', 'Neurologist', 2, '2345678901', 'alicesmith@hospital.com'),
    ('Robert', 'Brown', 'Pediatrician', 3, '3456789012', 'robertbrown@hospital.com'),
    ('Emma', 'Johnson', 'Orthopedic Surgeon', 4, '4567890123', 'emmajohnson@hospital.com'),
    ('David', 'Williams', 'Radiologist', 5, '5678901234', 'davidwilliams@hospital.com');


INSERT INTO Patients (first_name, last_name, gender, birth_date, phone_number, email, address, emergency_contact_name, emergency_contact_phone)
VALUES 
    ('Michael', 'Scott', 'Male', '1980-03-15', '9876543210', 'michaelscott@gmail.com', '123 Scranton Street', 'Jim Halpert', '8765432109'),
    ('Pam', 'Beesly', 'Female', '1985-06-25', '8765432109', 'pam.beesly@gmail.com', '456 Scranton Avenue', 'Angela Martin', '7654321098'),
    ('Dwight', 'Schrute', 'Male', '1978-01-20', '7654321098', 'dwight.schrute@dundermifflin.com', '789 Scranton Lane', 'Michael Scott', '6543210987'),
    ('Jim', 'Halpert', 'Male', '1983-10-01', '6543210987', 'jim.halpert@gmail.com', '101 Scranton Circle', 'Pam Beesly', '5432109876');


INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, reason)
VALUES 
    (1, 1, '2024-09-01', '09:00:00', 'Routine checkup for heart condition'),
    (2, 3, '2024-09-02', '11:00:00', 'Checkup for child vaccination'),
    (3, 2, '2024-09-03', '13:00:00', 'Consultation for headaches'),
    (4, 4, '2024-09-04', '15:00:00', 'Orthopedic surgery follow-up');

INSERT INTO Prescriptions (patient_id, doctor_id, appointment_id, prescription_date, medicine_details, instructions)
VALUES 
    (1, 1, 1, '2024-09-01', 'Aspirin 100mg', 'Take one tablet after meals for 7 days'),
    (2, 3, 2, '2024-09-02', 'Paracetamol 500mg', 'One tablet in case of fever'),
    (3, 2, 3, '2024-09-03', 'Ibuprofen 200mg', 'Take one tablet every 8 hours for 3 days'),
    (4, 4, 4, '2024-09-04', 'Vitamin D supplement', 'Take one tablet daily for 2 months');


INSERT INTO Rooms (room_number, room_type, availability_status, patient_id)
VALUES 
    ('101', 'Single', 'Occupied', 1),
    ('102', 'Double', 'Available', NULL),
    ('201', 'ICU', 'Occupied', 3),
    ('202', 'Single', 'Available', NULL);


INSERT INTO Billing (patient_id, appointment_id, total_amount, billing_date, payment_status)
VALUES 
    (1, 1, 500.00, '2024-09-01', 'Paid'),
    (2, 2, 300.00, '2024-09-02', 'Pending'),
    (3, 3, 450.00, '2024-09-03', 'Paid'),
    (4, 4, 1000.00, '2024-09-04', 'Pending');
