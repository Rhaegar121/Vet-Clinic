/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(250),
date_of_birth DATE,
escape_attempts INT,
neutered BOOLEAN,
weight_kg DECIMAL,
PRIMARY KEY(id)
);

/* Day 2 */
ALTER TABLE animals ADD species VARCHAR(250);

/* Day 3 */
CREATE TABLE owners(
id SERIAL PRIMARY KEY,
full_name VARCHAR(250),
age INT
);
CREATE TABLE species(
id SERIAL PRIMARY KEY,
name VARCHAR(250)
);
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owners_id INT REFERENCES owners(id);


/* Day 4 */
CREATE TABLE vets(
id SERIAL PRIMARY KEY,
name VARCHAR(250),
age INT,
date_of_graduation DATE
);
CREATE TABLE specializations(
vets_id INT REFERENCES vets (id),
species_id INT REFERENCES species (id)
);
CREATE TABLE visits(
animals_id INT REFERENCES animals (id),
vets_id INT REFERENCES vets (id),
date_of_visit DATE
);

/* Day 5 */
-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

/* Creating indexes to improve the execution time of the queries */
CREATE INDEX visits_animals_id_idx ON visits (animals_id);
CREATE INDEX visits_vets_id_idx ON visits (vets_id);
CREATE INDEX owners_email_idx ON owners (email);