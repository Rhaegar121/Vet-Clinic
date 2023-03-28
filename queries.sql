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