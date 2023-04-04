CREATE DATABASE clinic;

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
  id SERIAL not null PRIMARY KEY,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);


CREATE TABLE invoices (
    id SERIAL not null PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
    id SERIAL not null PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
);

/* Add foreign key indexes */
CREATE INDEX patient_id_idx ON patients(id);
CREATE INDEX medical_history_id_idx ON medical_histories(id);
CREATE INDEX treatment_id_idx ON treatments(id);
CREATE INDEX invoice_id_idx ON invoices(id);
CREATE INDEX invoice_items_id_idx ON invoice_items(id);
CREATE INDEX medical_history_treatments_id_idx ON medical_history_treatments(id);
CREATE INDEX medical_history_treatments_medical_history_id_idx ON medical_history_treatments(medical_history_id);
CREATE INDEX medical_history_treatments_treatmet_id_idx ON medical_history_treatments(treatment_id);