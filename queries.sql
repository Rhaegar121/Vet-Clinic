/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*Transaction queries*/
BEGIN; UPDATE animals SET species = 'unspecified'; ROLLBACK TRANSACTION;
BEGIN; UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon'; COMMIT;
BEGIN; UPDATE animals SET species = 'pokemon' WHERE species = ''; COMMIT;
BEGIN; DELETE FROM animals; ROLLBACK TRANSACTION;
BEGIN; DELETE FROM animals WHERE date_of_birth > '2022-01-01'; COMMIT;
BEGIN; SAVEPOINT SP1;
BEGIN; UPDATE animals SET weight_kg = weight_kg * -1; COMMIT;
ROLLBACK TO SP1;
BEGIN; UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0; COMMIT;
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT name, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY name;
SELECT name, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY name;

/* Write Day 3 quries */
SELECT animals.name FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name, animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT o.full_name AS owner_name, a.name AS animal_name FROM owners AS o LEFT JOIN animals AS a ON o.id = a.owners_id;
SELECT s.name AS species, COUNT(*) AS count FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.name;
SELECT o.full_name AS owner_name, a.name AS animal_name FROM owners AS o JOIN animals AS a ON o.id = a.owners_id WHERE o.full_name = 'Jennifer Orwell' AND a.species_id = 2;
SELECT animals.name FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT owners.full_name, COUNT(animals.id) AS num_animals FROM owners LEFT JOIN animals ON owners.id = animals.owners_id GROUP BY owners.id ORDER BY num_animals DESC LIMIT 1;