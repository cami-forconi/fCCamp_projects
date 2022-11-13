#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


# if there isn't an argument
if [[ $1 ]]
then
  # search elemnet by case
  REQUESTED_ELEMENT_RESULT=-1
  REQUESTED_ELEMENT=$1
  
  if [[ "$1" =~ [0-9]+ ]]
  then
    # search by atomic number
    REQUESTED_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number = $REQUESTED_ELEMENT;")

  elif [[ $1 =~ [A-Za-z]{3,} ]]
  then
    # search by name
    REQUESTED_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE name ILIKE '$REQUESTED_ELEMENT';")

  elif [[ $1 =~ [A-Z][a-z]? ]]
  then
    # search by symbol
    REQUESTED_ELEMENT_RESULT=$($PSQL "SELECT * FROM elements WHERE symbol = '$REQUESTED_ELEMENT';")

  else
    echo -e "I could not find that element in the database." 
    exit 1
  fi

  # if the element wasn't found on the elements table
  if [[ "$REQUESTED_ELEMENT_RESULT" -eq "-1" || -z $REQUESTED_ELEMENT_RESULT ]]
  then
    echo -e "I could not find that element in the database."
  else
    # read requested element results
    echo "$REQUESTED_ELEMENT_RESULT" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME
    do
      # search element's properties
      SEARCH_PROPERTIES_RESULT=$($PSQL "SELECT * FROM properties WHERE atomic_number = $ATOMIC_NUMBER")

      # if the element's properties weren't found on the properties table
      if [[ -z $SEARCH_PROPERTIES_RESULT ]]
      then
        echo -e "I could not find the element's properties :( \n"
      else
        # read requested element results
        echo "$SEARCH_PROPERTIES_RESULT" | while read ATOM_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID
        do
          # search type
          TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
          TYPE=$(echo $TYPE | sed 's/ *//')
          echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    done  
  fi
  else
    echo -e "Please provide an element as an argument."
fi
