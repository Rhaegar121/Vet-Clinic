CREATE TABLE patients (
  id INT PRIMARY KEY,
  name VARCHAR(250),
  date_of_birth DATE
);

CREATE TABLE medical_histories(
  id SERIAL not null PRIMARY KEY,
  patients_id INT REFERENCES patients (id),
  admitted_at TIMESTAMP,
  status VARCHAR(250)
);

CREATE TABLE treatments (
  id SERIAL not null PRIMARY KEY,
  type VARCHAR(250),
  name VARCHAR(250)
);

CREATE TABLE medical_history_treatments (
  medical_history_id INT,
  treatment_id INT,
  PRIMARY KEY (medical_history_id, treatment_id),
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);
