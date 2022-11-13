#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

# Resetting tables and sequences
echo $($PSQL "TRUNCATE TABLE games, users;")
echo $($PSQL "ALTER SEQUENCE games_game_id_seq RESTART WITH 1;")
echo $($PSQL "ALTER SEQUENCE users_user_id_seq RESTART WITH 1;")
