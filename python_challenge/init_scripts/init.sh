#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE TABLE athletes(
    Name varchar(100) NOT NULL,
    NOC varchar(100) NOT NULL,
    Discipline varchar(100) NOT NULL
  );
  CREATE TABLE coaches(
    Name varchar(100) NOT NULL,
    NOC varchar(100) NOT NULL,
    Discipline varchar(100) NOT NULL,
    Event varchar(70)
  );
  CREATE TABLE gender(
    Discipline varchar(100) NOT NULL,
    Female numeric NOT NULL,
    Male numeric NOT NULL,
    Total numeric NOT NULL
  );
  CREATE TABLE medals(
    Rank numeric NOT NULL,
    "Team/NOC" varchar(100) NOT NULL,
    Gold numeric NOT NULL,
    Silver numeric NOT NULL,
    Bronze numeric NOT NULL,
    Total numeric NOT NULL,
    "Rank By Total" numeric NOT NULL
  );
  CREATE TABLE teams(
    Name varchar(100) NOT NULL,
    NOC varchar(100) NOT NULL,
    Discipline varchar(100) NOT NULL,
    Event varchar(100)
  );




EOSQL