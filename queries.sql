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

/* Write Day 4 quries */
/* Who was the last animal seen by William Tatcher? */
SELECT animals.name AS animal_name
FROM vets 
JOIN visits ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'Vet William Tatcher'
ORDER BY visits.date_of_visit DESC LIMIT 1;

/* How many different animals did Stephanie Mendez see? */
SELECT vets.name AS vet_name, COUNT(DISTINCT animals.id) AS numbers_of_animals
FROM vets
JOIN visits ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'Vet Stephanie Mendez'
GROUP BY vets.name;

/* List all vets and their specialties, including vets with no specialties. */
SELECT vets.name AS vet_name, species.name AS specialties
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vets_id
LEFT JOIN species ON species.id = specializations.species_id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT vets.name AS vet_name, animals.name AS animal_name
FROM vets
JOIN visits ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'Vet Stephanie Mendez' AND
visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

/* What animal has the most visits to vets? */
SELECT animals.name AS animal_name, COUNT(animals.id) AS numbers_of_visits
FROM visits
JOIN animals ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY COUNT(animals.id) DESC LIMIT 1;

/* Who was Maisy Smith's first visit? */
SELECT animals.name AS animal_name, visits.date_of_visit AS first_visit
FROM vets
JOIN visits ON vets.id = visits.vets_id
JOIN animals ON visits.animals_id = animals.id
WHERE vets.name = 'Vet Maisy Smith'
ORDER BY visits.date_of_visit LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT animals.name AS name,
animals.date_of_birth AS date_of_birth,
animals.escape_attempts AS escape_attempts,
animals.neutered AS neutered,
animals.weight_kg AS weight_kg,
vets.name AS vet_name,
vets.age AS vet_age,
vets.date_of_graduation AS date_of_graduation,
visits.date_of_visit AS visit_date
FROM vets
JOIN visits ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
ORDER BY visits.date_of_visit DESC LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT vets.name AS vet_name,
COUNT(visits.animals_id) AS numbers_of_visits
FROM visits
JOIN vets ON visits.vets_id = vets.id
JOIN animals ON animals.id = visits.animals_id
FULL JOIN specializations ON visits.vets_id = specializations.vets_id
GROUP BY visits.animals_id, vets.name
ORDER BY COUNT(visits.animals_id) DESC
LIMIT 1;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT species.name AS species_name, vets.name AS vet_name, COUNT(*) AS numbers_of_visits
FROM vets
JOIN visits ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Vet Maisy Smith'
GROUP BY species.name, vets.name
ORDER BY COUNT(*) DESC LIMIT 1;