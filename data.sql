/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)   
VALUES ('Agumon', '2020-02-3', 10.23, false, 0),
  ('Gabumon', '2018-11-15', 8, true, 2),
  ('Pikachu', '2021-01-07', 15.04, false, 1),
  ('Devimon', '2017-05-12', 11, true, 5);

/* Add more records (Project 2)  */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Charmander', '2020-02-08', -11, false, 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Plantmon', '2021-11-15', -5.7, true, 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Squirtle', '1993-04-02', -12.13, false, 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Angemon', '2005-06-12', -45, true, 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Boarmon', '2005-06-07', 20.4, true, 7);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Blossom', '1998-10-13', 17, true, 3);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Ditto', '2022-05-14', 22, true, 4);

/*  Update/Data queries to animals, owners, and species tables (Project 3) */

-- Insert data into owners table:

INSERT INTO OWNERS (FULL_NAME, AGE)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 38),
('Jodie Whittaker', 38);

-- Insert data into species table

INSERT INTO SPECIES (NAME)
VALUES ('Pokemon'), ('Digimon');

-- Update foreign key species_id in animals table with correct species id

UPDATE ANIMALS
SET SPECIES_ID = 2
WHERE NAME LIKE '%mon';

UPDATE ANIMALS
SET SPECIES_ID = 1
WHERE SPECIES_ID IS NULL;

-- Update animals table to have the following owner_id data

-- Sam Owns Agumon
UPDATE ANIMALS
SET OWNER_ID = (SELECT ID FROM OWNERS WHERE FULL_NAME = 'Sam Smith')
WHERE NAME = 'Agumon';

-- Jennifer owns a Gabumon & Pikachu
UPDATE ANIMALS
SET OWNER_ID = (SELECT ID FROM OWNERS WHERE FULL_NAME = 'Jennifer Orwell')
WHERE NAME = 'Gabumon' OR NAME = 'Pikachu';

-- Bob owns Devimon and Plantmon
UPDATE ANIMALS
SET OWNER_ID = (SELECT ID FROM OWNERS WHERE FULL_NAME = 'Bob')
WHERE NAME = 'Devimon' OR NAME = 'Plantmon';

-- Melody owns Charmander, Squirtle, and Blossom
UPDATE ANIMALS
SET OWNER_ID = (SELECT ID FROM OWNERS WHERE FULL_NAME = 'Melody Pond')
WHERE NAME = 'Charmander' OR NAME = 'Squirtle' OR NAME = 'Blossom';

-- Dean owns Angemon and Boarmon
UPDATE ANIMALS
SET OWNER_ID = (SELECT ID FROM OWNERS WHERE FULL_NAME = 'Dean Winchester')
WHERE NAME = 'Angemon' OR NAME = 'Boarmon';

/* Insert data into tables  (Project 3 - Join tables) */

-- Insert following data into VETS table

INSERT INTO VETS (NAME, AGE, DATE_OF_GRADUATION)
VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 28, '2008-06-08');

---- Insert specializations table data

-- William Tatcher specialized in pokemon

INSERT INTO SPECIALIZATIONS (SPECIES_ID, VET_ID)
VALUES (
  (SELECT ID FROM SPECIES WHERE NAME = 'Pokemon'),
  (SELECT ID FROM VETS WHERE NAME = 'William Tatcher')
);

-- Stephanie Mendez specialized in Pokemon & Digimon

INSERT INTO SPECIALIZATIONS (SPECIES_ID, VET_ID)
VALUES (
  (SELECT ID FROM SPECIES WHERE NAME = 'Pokemon'),
  (SELECT ID FROM VETS WHERE NAME = 'Stephanie Mendez')
),
(
  (SELECT ID FROM SPECIES WHERE NAME = 'Digimon'),
  (SELECT ID FROM VETS WHERE NAME = 'Stephanie Mendez')
);

-- Jack Harkness specialized in Digimon

INSERT INTO SPECIALIZATIONS (SPECIES_ID, VET_ID)
VALUES (
  (SELECT ID FROM SPECIES WHERE NAME = 'Digimon'),
  (SELECT ID FROM VETS WHERE NAME = 'Jack Harkness')
);

---- Insert visits table data as follows

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Agumon'),
  (SELECT ID FROM VETS WHERE NAME = 'Wiliiam Tatcher'),
  '2020-05-24'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Agumon'),
  (SELECT ID FROM VETS WHERE NAME = 'Stephanie Mendez'),
  '2020-07-22'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'GABUMON'),
  (SELECT ID FROM VETS WHERE NAME = 'Jack Harkness'),
  '2021-02-02'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Pikachu'),
  (SELECT ID FROM VETS WHERE NAME = 'Maisy Smith'),
  '2020-01-05'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Pikachu'),
  (SELECT ID FROM VETS WHERE NAME = 'Maisy Smith'),
  '2020-05-08'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Pikachu'),
  (SELECT ID FROM VETS WHERE NAME = 'Maisy Smith'),
  '2020-05-14'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Devimon'),
  (SELECT ID FROM VETS WHERE NAME = 'Stephanie Mendez'),
  '2021-05-04'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Charmander'),
  (SELECT ID FROM VETS WHERE NAME = 'Jack Harkness'),
  '2021-02-24'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Plantmon'),
  (SELECT ID FROM VETS WHERE NAME = 'Maisy Smith'),
  '2019-12-21'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Plantmon'),
  (SELECT ID FROM VETS WHERE NAME = 'William Tatcher'),
  '2020-08-10'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Plantmon'),
  (SELECT ID FROM VETS WHERE NAME = 'Maisy Smith'),
  '2021-04-07'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Squirtle'),
  (SELECT ID FROM VETS WHERE NAME = 'Stephanie Mendez'),
  '2019-09-29'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Angemon'),
  (SELECT ID FROM VETS WHERE NAME = 'Jack Harkness'),
  '2020-10-03'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Angemon'),
  (SELECT ID FROM VETS WHERE NAME = 'Jack Harkness'),
  '2020-11-04'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Boarmon'),
  (SELECT ID FROM VETS WHERE NAME = 'Maisy Smith'),
  '2019-01-24'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Boarmon'),
  (SELECT ID FROM VETS WHERE NAME = 'Maisy Smith'),
  '2019-05-15'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Boarmon'),
  (SELECT ID FROM VETS WHERE NAME = 'Maisy Smith'),
  '2020-02-27'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Boarmon'),
  (SELECT ID FROM VETS WHERE NAME = 'Maisy Smith'),
  '2020-08-03'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Boarmon'),
  (SELECT ID FROM VETS WHERE NAME = 'Stephanie Mendez'),
  '2020-05-24'
);

INSERT INTO VISITS (ANIMAL_ID, VET_ID, VISIT_DATE)
VALUES (
  (SELECT ID FROM ANIMALS WHERE NAME = 'Boarmon'),
  (SELECT ID FROM VETS WHERE NAME = 'William Tatcher'),
  '2021-01-11'
);
