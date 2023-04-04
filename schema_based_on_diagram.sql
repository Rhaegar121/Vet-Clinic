CREATE TABLE medical_histories(
  id INT PRIMARY KEY,
  patients_id INT REFERENCES patients (id),
  admitted_at TIMESTAMP,
  status VARCHAR(250)
);

CREATE TABLE treatments (
  id INT PRIMARY KEY,
  type VARCHAR(250),
  name VARCHAR(250)
);

CREATE TABLE medical_history_treatments (
  medical_history_id INT REFERENCES REFERENCES medical_histories(id),,
  treatment_id INT REFERENCES REFERENCES treatments(id),
);

CREATE TABLE patients (
  id INT PRIMARY KEY,
  name VARCHAR(250),
  date_of_birth DATE
)