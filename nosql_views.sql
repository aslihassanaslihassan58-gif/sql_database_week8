-- NoSQL JSONB - patient feedback
INSERT INTO patient_feedback (data) VALUES
('{"patient_id": 1, "patient_name": "John Kamau", "feedback": "Doctor was very helpful", "rating": 5, "tags": ["friendly", "fast"]}'),
('{"patient_id": 2, "patient_name": "Amina Hassan", "feedback": "Waiting time was long", "rating": 3, "tags": ["slow", "clean"]}'),
('{"patient_id": 3, "patient_name": "Peter Mwangi", "feedback": "Great pharmacy service", "rating": 4, "tags": ["helpful"]}');

-- NoSQL queries
SELECT data->>'patient_name' AS name, data->>'feedback' AS feedback FROM patient_feedback WHERE (data->>'rating')::INT >= 4;

-- Dashboard views
CREATE OR REPLACE VIEW vw_dashboard_stats AS
SELECT
  (SELECT COUNT(*) FROM patients) AS total_patients,
  (SELECT COUNT(*) FROM doctors) AS total_doctors,
  (SELECT COALESCE(SUM(total_amount),0) FROM invoices WHERE status='PAID') AS total_revenue_paid,
  (SELECT COALESCE(SUM(total_amount),0) FROM invoices WHERE status='UNPAID') AS total_unpaid;

-- Optimization + Reports
-- EXPLAIN ANALYZE SELECT * FROM patients WHERE phone = '0722111222';
-- SELECT status, COUNT(*), SUM(total_amount) FROM invoices GROUP BY status;
-- SELECT a.appointment_date, p.full_name, d.specialization FROM appointments a JOIN patients p ON a.patient_id=p.patient_id JOIN doctors d ON a.doctor_id=d.doctor_id;
