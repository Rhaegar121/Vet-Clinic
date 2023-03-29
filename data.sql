/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-2-3', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-1-7', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-5-12', 5, true, 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-2-8', 0, false, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-4-2', 3, false, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-6-12', 1, true, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-6-7', 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-5-14', 4, true, 22);

/* Insert the following data into the owners table */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

/* Insert the following data into the species table */
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

/* Modify inserted animals so it includes the species_id value */
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;

/* Modify inserted animals to include owner information (owner_id) */
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')  WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Bob')  WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')  WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')  WHERE name IN ('Angemon', 'Boarmon');


INSERT INTO vets (name, age, date_of_graduation) VALUES ('Vet William Tatcher', 45, '2000-04-23'), ('Vet Maisy Smith', 26, '2019-01-17'), ('Vet Stephanie Mendez', 64, '1981-05-04'), ('Vet Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vets_id, species_id) VALUES (1, 1), (3, 2), (3, 1), (4, 2);