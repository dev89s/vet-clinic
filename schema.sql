/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOL,
    weight_kg DECIMAL
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

/* Project 3 - Add 2 new tables and alter animals table */

-- Create new table called owners

CREATE TABLE OWNERS (
    ID INT GENERATED ALWAYS AS IDENTITY,
    FULL_NAME VARCHAR(255) NOT NULL,
    AGE INT NOT NULL,
    PRIMARY KEY(ID)
);

-- Create new table called species

CREATE TABLE SPECIES (
    ID INT GENERATED ALWAYS AS IDENTITY,
    NAME VARCHAR(255) NOT NULL,
    PRIMARY KEY(ID)
);

-- Alter table animals and remove column species

ALTER TABLE ANIMALS
DROP COLUMN SPECIES;

SELECT * FROM ANIMALS;

-- Add a foreign key column named SPECIES_ID

ALTER TABLE ANIMALS ADD COLUMN SPECIES_ID INT;
ALTER TABLE ANIMALS
ADD CONSTRAINT FK_SPECIES FOREIGN KEY(SPECIES_ID) REFERENCES SPECIES(ID);

-- Add a foreign key column named OWNER_ID

ALTER TABLE ANIMALS ADD COLUMN OWNER_ID INT;
ALTER TABLE ANIMALS
ADD CONSTRAINT FK_OWNER FOREIGN KEY(OWNER_ID) REFERENCES OWNERS(ID);
