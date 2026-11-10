INSERT INTO departments (name, location) VALUES
('General Medicine','Ground Floor'),('Pediatrics','1st Floor'),
('Cardiology','2nd Floor'),('Pharmacy','Ground Floor')
ON CONFLICT (name) DO NOTHING;

INSERT INTO users (full_name, email, password_hash, role) VALUES
('Admin Asli','admin@medicare.co.ke','$2b$10$hashedpassword123','ADMIN'),
('Dr. Wanjiru','wanjiru@medicare.co.ke','$2b$10$hashedpassword456','DOCTOR'),
('Dr. Otieno','otieno@medicare.co.ke','$2b$10$hashedpassword789','DOCTOR'),
('Mary Reception','mary@medicare.co.ke','$2b$10$hashedpassword000','RECEPTIONIST')
ON CONFLICT (email) DO NOTHING;

INSERT INTO doctors (user_id, department_id, specialization, license_no, phone) VALUES
(2, 1, 'General Physician','KMP-001','0722000001'),
(3, 3, 'Cardiologist','KMP-002','0722000002')
ON CONFLICT (license_no) DO NOTHING;

INSERT INTO patients (full_name, national_id, dob, gender, phone, email) VALUES
('John Kamau','12345678','1990-05-12','Male','0722111222','john@gmail.com'),
('Amina Hassan','87654321','1995-08-20','Female','0722333444','amina@gmail.com'),
('Peter Mwangi','11223344','1988-01-15','Male','0722555666','peter@gmail.com')
ON CONFLICT (national_id) DO NOTHING;

INSERT INTO medications (name, description, stock_quantity, unit_price) VALUES
('Paracetamol 500mg','Pain relief',500,50.00),
('Amoxicillin 500mg','Antibiotic',200,150.00),
('Omeprazole 20mg','Acid reflux',150,120.00)
ON CONFLICT (name) DO NOTHING;

INSERT INTO appointments (patient_id, doctor_id, appointment_date, start_time, end_time, reason) VALUES
(1, 1, '2026-11-11','09:00','09:30','Fever and headache'),
(2, 2, '2026-11-11','10:00','10:30','Chest pain checkup')
ON CONFLICT DO NOTHING;

CREATE INDEX IF NOT EXISTS idx_patients_phone ON patients(phone);
CREATE INDEX IF NOT EXISTS idx_patients_name ON patients(full_name);
CREATE INDEX IF NOT EXISTS idx_appointments_date ON appointments(appointment_date);
CREATE INDEX IF NOT EXISTS idx_appointments_doctor ON appointments(doctor_id);
CREATE INDEX IF NOT EXISTS idx_records_patient ON medical_records(patient_id);
CREATE INDEX IF NOT EXISTS idx_invoices_patient ON invoices(patient_id);
