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
