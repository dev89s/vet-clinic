/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-1-1' AND date_of_birth <= '2019-1-1';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals where name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <= 17.3;

/* Queries that manipulate data on table aniqumals (Project 2) */

-- Update the table animals by setting species column to unspecified
BEGIN;

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Update the table animals for species of digimon and pokemon
BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species is NULL;

SELECT * FROM animals;

COMMIT;

-- Delete all records in animals table
BEGIN;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

-- Delete animals born after 2022 Jan 1st & Fix the negative weights
BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT birth_date;

UPDATE animals
SET weight_kg = weight_kg * -1;

SELECT * FROM animals;

ROLLBACK TO SAVEPOINT birth_date;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SELECT * FROM animals;

COMMIT;

/* Queries that answer questions (Project 2) */

--  How many animals are there?

SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?

SELECT COUNT(name), escape_attempts from animals
WHERE escape_attempts = (SELECT MIN(escape_attempts) FROM animals)
GROUP BY escape_attempts;

-- What is the average weight of the animals?

SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered?
SELECT neutered, SUM(escape_attempts) AS escape_attemtps_sum FROM animals
GROUP BY neutered 
HAVING SUM(escape_attempts) = (
SELECT MAX(sum) FROM (
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered
) as max_escaped_neuter_type
);

-- What is the minimum and maximum weight of each type of animal?

SELECT MAX(weight_kg) AS min_weight, MIN(weight_kg) as max_weight, species from animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts), species FROM animals
WHERE date_of_birth > '1990-01-01' AND date_of_birth < '2000-01-01'
GROUP BY species;


/* Queries made on table joins (Project 3) */

-- What animals belong to Melody Pond

SELECT NAME FROM ANIMALS
JOIN OWNSERS ON ANIMALS.OWNER_ID = OWNERS.ID
WHERE FULL_NAME = 'Melody Pond';

-- List all animals that are of species Pokemon

SELECT ANIMALS.NAME FROM ANIMALS
JOIN SPECIES ON ANIMALS.SPECIES_ID = SPECIES.ID
WHERE SPECIES.NAME = 'Pokemon';

-- List all owners and their animals including those with no animal

SELECT FULL_NAME, NAME FROM OWNERS
LEFT JOIN ANIMALS ON ANIMALS.OWNER_ID = OWNERS.ID;

-- How many animals are there per species?

SELECT COUNT(ANIMALS.NAME), SPECIES.NAME FROM SPECIES
JOIN ANIMALS ON ANIMALS.SPECIES_ID = SPECIES.ID
GROUP BY SPECIES.NAME;

-- List all digimons owned by Jennifer Orwell

SELECT ANIMALS.NAME FROM ANIMALS
JOIN OWNERS ON OWNERS.ID = ANIMALS.OWNER_ID
JOIN SPECIES ON SPECIES.ID = ANIMALS.SPECIES_ID
WHERE SPECIES.NAME = 'Digimon' AND FULL_NAME = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape

SELECT ANIMALS.NAME FROM ANIMALS
JOIN OWNERS ON OWNERS.ID = ANIMALS.OWNER_ID
WHERE FULL_NAME = 'Dean Winchester' AND ESCAPE_ATTEMPTS = 0;

-- Who owns the most animals? (Again: To be or not to be 🤦‍♂️)

SELECT COUNT(ANIMALS.NAME), FULL_NAME FROM ANIMALS
JOIN OWNERS ON OWNERS.ID = ANIMALS.OWNER_ID
GROUP BY FULL_NAME
HAVING COUNT(ANIMALS.NAME) = (
  SELECT MAX(ANIMAL_COUNT) FROM (
    SELECT COUNT(ANIMALS.NAME) AS ANIMAL_COUNT, FULL_NAME FROM ANIMALS
    JOIN OWNERS ON OWNERS.ID = ANIMALS.OWNER_ID
    GROUP BY FULL_NAME
  ) AS AN_COUNT_TABLE
);

/* Table join queries (Project 3) */

-- Who was the last animal seen by Williams Tatcher

SELECT ANIMALS.NAME, VISIT_DATE FROM ANIMALS
JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
JOIN VETS ON VETS.ID = VISITS.VET_ID
JOIN (
  SELECT MAX(VISIT_DATE) FROM (
    SELECT ANIMALS.NAME, VISIT_DATE FROM ANIMALS
    JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
    JOIN VETS ON VETS.ID = VISITS.VET_ID
    WHERE VETS.NAME = 'William Tatcher'
  ) AS WILLIAMS_VISITS
) AS MAX_DATE ON VISIT_DATE = MAX_DATE.MAX;

-- How many different animals did Stephanie Mendez see?

SELECT VETS.NAME AS VET_NAME,
COUNT(DISTINCT(ANIMALS.NAME)) AS KIND_OF_ANIMALS_VISITED
FROM ANIMALS
JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
JOIN VETS ON VISITS.VET_ID = VETS.ID
WHERE VETS.NAME = 'Stephanie Mendez'
GROUP BY VETS.NAME;

-- List all vets and their specializations, including those with non

SELECT VETS.NAME AS VET_NAME,
SPECIES.NAME AS SPECIES
FROM VETS
LEFT JOIN SPECIALIZATIONS ON SPECIALIZATIONS.VET_ID = VETS.ID
LEFT JOIN SPECIES ON SPECIALIZATIONS.SPECIES_ID = SPECIES.ID;

-- List all animals that visited Stephanie Mendez between April 1st, and August 30th, 2020

SELECT ANIMALS.NAME FROM ANIMALS
JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
JOIN VETS ON VETS.ID = VISITS.VET_ID
WHERE VETS.NAME = 'Stephanie Mendez'
AND VISIT_DATE > '2020-04-01'
AND VISIT_DATE < '2020-08-30';

-- What animal has the most visits to the vets

SELECT ANIMALS.NAME, COUNT(DISTINCT(VISIT_DATE)) FROM ANIMALS
JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
JOIN VETS ON VETS.ID = VISITS.VET_ID
GROUP BY ANIMALS.NAME
HAVING COUNT(DISTINCT(VISIT_DATE)) = (
  SELECT MAX(COUNT) FROM (
    SELECT ANIMALS.NAME, COUNT(DISTINCT(VISIT_DATE)) FROM ANIMALS
    JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
    JOIN VETS ON VETS.ID = VISITS.VET_ID
    GROUP BY ANIMALS.NAME
  ) AS ANIMAL_VISIT_COUNTS
);

-- Who was Maisy Smith's first visit?

SELECT ANIMALS.NAME, VISIT_DATE FROM ANIMALS
JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
JOIN VETS ON VETS.ID = VISITS.VET_ID
WHERE VISIT_DATE = (
  SELECT MIN(VISIT_DATE) FROM (
    SELECT VISIT_DATE FROM ANIMALS
    JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
    JOIN VETS ON VETS.ID = VISITS.VET_ID
    WHERE VETS.NAME = 'Maisy Smith'
  ) AS VISIT_DATES
);

-- Details for most recent visit: animal information, vet info, date of visit

SELECT DISTINCT
ANIMAL_NAME,
VET_NAME,
VISIT_DATE,
WEIGHT_KG AS ANIMAL_WEIGHT,
NEUTERED AS ANIMAL_NEUTERED,
ESCAPE_ATTEMPTS AS ANUMAL_ESCAPE_ATTEMPTS,
VET_AGE AS VET_AGE
 FROM (
  SELECT
  ANIMALS.NAME AS ANIMAL_NAME,
  WEIGHT_KG,
  NEUTERED,
  ESCAPE_ATTEMPTS,
  VETS.NAME AS VET_NAME,
  VETS.AGE AS VET_AGE,
  VISIT_DATE
  FROM ANIMALS
  JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
  JOIN VETS ON VISITS.VET_ID = VETS.ID
) AS VET_VISIT
JOIN (  
  SELECT MIN(VISIT_DATE) FROM ANIMALS
  JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
  JOIN VETS ON VETS.ID = VISITS.VET_ID
  GROUP BY (ANIMALS.NAME, VETS.NAME)
) AS MIN_DATES ON VISIT_DATE = MIN
ORDER BY (VISIT_DATE);

-- How many visits were with a vet that did not specialize in
-- that animal's species

SELECT COUNT(*) FROM (
  SELECT DISTINCT
  ANIMALS.NAME AS ANIMAL_NAME,
  S1.NAME AS ANIMALS_SPECIES,
  VETS.NAME AS VET_NAME,
  SPECIES.NAME AS VETS_SPECIALIZATION
  FROM ANIMALS
  JOIN SPECIES S1 ON S1.ID = ANIMALS.SPECIES_ID
  JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
  JOIN VETS ON VETS.ID = VISITS.VET_ID
  JOIN SPECIALIZATIONS ON VETS.ID = SPECIALIZATIONS.VET_ID
  JOIN SPECIES ON SPECIES.ID = SPECIALIZATIONS.SPECIES_ID
  WHERE S1.NAME != SPECIES.NAME
) AS UNWISE_VISITS;

-- What specialty Maisy Smith should get?
-- Look for the species she gets the most.

SELECT NAME FROM (
  SELECT COUNT(ANIMALS.NAME), SPECIES.NAME FROM SPECIES
  JOIN ANIMALS ON ANIMALS.SPECIES_ID = SPECIES.ID
  JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
  JOIN VETS ON VETS.ID = VISITS.VET_ID
  WHERE VETS.NAME = 'Maisy Smith'
  GROUP BY SPECIES.NAME
) AS VET_SPECIALTY
WHERE COUNT = (
  SELECT MAX(COUNT) FROM (
    SELECT COUNT(ANIMALS.NAME), SPECIES.NAME FROM SPECIES
    JOIN ANIMALS ON ANIMALS.SPECIES_ID = SPECIES.ID
    JOIN VISITS ON VISITS.ANIMAL_ID = ANIMALS.ID
    JOIN VETS ON VETS.ID = VISITS.VET_ID
    WHERE VETS.NAME = 'Maisy Smith'
    GROUP BY SPECIES.NAME
  ) AS VET_SPECIALTY
);
