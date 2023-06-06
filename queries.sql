/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth >= '2016-1-1' AND date_of_birth <= '2018-1-1';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT name, date_of_birth FROM animals where name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <= 17.3;
