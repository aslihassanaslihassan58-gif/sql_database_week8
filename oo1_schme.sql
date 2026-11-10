-- 001_schema.sql - Hospital Management System
CREATE TABLE IF NOT EXISTS departments (
  department_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  location VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS users (
  user_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role VARCHAR(20) CHECK (role IN ('ADMIN','DOCTOR','RECEPTIONIST','PHARMACIST')) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS doctors (
  doctor_id SERIAL PRIMARY KEY,
  user_id INT UNIQUE REFERENCES users(user_id) ON DELETE CASCADE,
  department_id INT REFERENCES departments(department_id),
  specialization VARCHAR(100),
  license_no VARCHAR(50) UNIQUE,
  phone VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS patients (
  patient_id SERIAL PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  national_id VARCHAR(20) UNIQUE,
  dob DATE,
  gender VARCHAR(10) CHECK (gender IN ('Male','Female','Other')),
  phone VARCHAR(20),
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS appointments (
  appointment_id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES patients(patient_id) ON DELETE CASCADE,
  doctor_id INT REFERENCES doctors(doctor_id),
  appointment_date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  reason TEXT,
  status VARCHAR(20) DEFAULT 'SCHEDULED' CHECK (status IN ('SCHEDULED','COMPLETED','CANCELLED')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS medical_records (
  record_id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES patients(patient_id) ON DELETE CASCADE,
  doctor_id INT REFERENCES doctors(doctor_id),
  appointment_id INT UNIQUE REFERENCES appointments(appointment_id),
  diagnosis TEXT,
  symptoms TEXT,
  visit_date DATE DEFAULT CURRENT_DATE
);
CREATE TABLE IF NOT EXISTS medications (
  medication_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  description TEXT,
  stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
  unit_price DECIMAL(10,2) NOT NULL
);
CREATE TABLE IF NOT EXISTS prescriptions (
  prescription_id SERIAL PRIMARY KEY,
  record_id INT REFERENCES medical_records(record_id) ON DELETE CASCADE,
  medication_id INT REFERENCES medications(medication_id),
  dosage VARCHAR(50),
  frequency VARCHAR(50),
  duration_days INT
);
CREATE TABLE IF NOT EXISTS invoices (
  invoice_id SERIAL PRIMARY KEY,
  patient_id INT REFERENCES patients(patient_id),
  appointment_id INT REFERENCES appointments(appointment_id),
  total_amount DECIMAL(10,2) NOT NULL,
  status VARCHAR(20) DEFAULT 'UNPAID' CHECK (status IN ('PAID','UNPAID','PARTIAL')),
  issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS payments (
  payment_id SERIAL PRIMARY KEY,
  invoice_id INT REFERENCES invoices(invoice_id) ON DELETE CASCADE,
  amount DECIMAL(10,2) NOT NULL,
  method VARCHAR(20) CHECK (method IN ('MPESA','CASH','CARD','INSURANCE')),
  paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS patient_feedback (
  id SERIAL PRIMARY KEY,
  data JSONB NOT NULL
);
