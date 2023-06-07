/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-1-1' AND date_of_birth <= '2019-1-1';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals where name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <= 17.3;

/* Queries that manipulate data on table animals (Project 2) */

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

-- Who escapes the most, neutered or not neutered animals?

SELECT MAX(weight_kg) AS min_weight, MIN(weight_kg) as max_weight, species from animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts), species FROM animals
WHERE date_of_birth > '1990-01-01' AND date_of_birth < '2000-01-01'
GROUP BY species;
