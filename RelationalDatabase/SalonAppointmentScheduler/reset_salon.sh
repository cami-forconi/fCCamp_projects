#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

# Resetting tables and sequences
echo $($PSQL "TRUNCATE TABLE customers, appointments;")
echo $($PSQL "ALTER SEQUENCE customers_customer_id_seq RESTART WITH 1;")
echo $($PSQL "ALTER SEQUENCE appointments_appointment_id_seq RESTART WITH 1;")
