#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {

  # if there's an argument
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "\nList of services:"
  SERVICE_RESULT=$($PSQL "SELECT * FROM services ORDER BY service_id" )

  echo "$SERVICE_RESULT" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo -e "$SERVICE_ID) $SERVICE_NAME"
  done

  echo -e "\nWhat service from Camp Salon would you like?" 
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
  [1-5]) ADD_APPOINTMENT $SERVICE_ID_SELECTED ;;
  *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac
}

ADD_APPOINTMENT() {

  # get service name
  SERVICE_ID_SELECTED=$1
  SERVICE_NAME_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED" )
  SERVICE_NAME_SELECTED=$(echo $SERVICE_NAME_SELECTED | sed 's/ *//')

  # get customer's phone
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  
  # get customer's name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'" )
  CUSTOMER_NAME=$(echo $CUSTOMER_NAME | sed 's/ *//')

  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get customer's name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    
    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')" )
  fi
  
  # get appointment's time
  echo -e "\nAt what time would you like your appointment, $CUSTOMER_NAME?" 
  
  read SERVICE_TIME

  #egt customer's id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'" )

  # insert new appointment
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')" )

  echo -e "\nI have put you down for a $SERVICE_NAME_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."

}


MAIN_MENU
