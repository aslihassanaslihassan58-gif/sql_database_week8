# Hospital Management System - MediCare
Capstone - SQL Database Week 8

## Tech
- PostgreSQL (Neon Cloud) - Relational
- JSONB - NoSQL Document Store
- Indexes + EXPLAIN ANALYZE - Optimization

## Files
- 001_schema.sql - 11 tables
- 002_seed_data_and_indexes.sql - Sample data + 6 indexes
- 003_clinical_data.sql - Records, prescriptions, invoices, payments
- 004_nosql_and_views.sql - JSONB feedback + dashboard views

## How to Run
1. Create Neon DB
2. Run files in order 001 -> 004

## Results
- Patients: 3, Doctors: 2
- Revenue PAID: 1500, UNPAID: 2500
- Index Scan proven with EXPLAIN ANALYZE
