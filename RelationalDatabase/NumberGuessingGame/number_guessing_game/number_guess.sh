#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

MAIN() {

  if [[ $1 ]]
  then
    echo -e "\n$1\n"
  fi

  echo -e "Enter your username:"
  read USERNAME
  
  LENGTH=${#USERNAME}

  # check length of username
  if [[ $LENGTH -gt 30 ]]
  then
    MAIN "Please enter an username with less tan 30 characters..."
  else
    # search username
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username ILIKE '$USERNAME'" )

    # if not found
    if [[ -z $USER_ID ]]
    then
      # welcome message
      echo -e "Welcome, $USERNAME! It looks like this is your first time here."

    else
      # get number of games played and best game
      GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id = $USER_ID" )
      BEST_GAME=$($PSQL "SELECT MIN(num_guesses) FROM games WHERE user_id = $USER_ID" )
      
      # welcome message
      echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    fi

    # generate random number
    SECRET_NUMBER=$(( RANDOM%1000 + 1 ))

    # set count and guess variables
    COUNT=0

    echo -e "\nGuess the secret number between 1 and 1000:"
    read GUESS

    until [ $GUESS -eq $SECRET_NUMBER ]
    do
      # check that the guess is an integer
      if [[ $GUESS =~ [0-9]+ ]]
      then
        # raise counter
        (( COUNT++ ))

        # give feedback to the user
        if [[ $GUESS < $SECRET_NUMBER ]]
        then
          echo -e "\nIt's higher than that, guess again:"
        elif [[ $GUESS > $SECRET_NUMBER ]]
        then
          echo -e "\nIt's lower than that, guess again:"
        fi

      else
        echo -e "\nThat is not an integer, guess again:"
      fi

      read GUESS
    done

    # raise counter one last time 
    (( COUNT++ ))

    # congratulations message
    echo -e "\nYou guessed it in $COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"


    if [[ $COUNT -ne 0 ]]
    then
      if [[ -z $USER_ID ]]
      then
        # insert user in the users table and get new user id
        INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')" )
        USER_ID=$($PSQL "SELECT user_id FROM users WHERE username ILIKE '$USERNAME'" )
      fi

      # insert game in the games table
      INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(user_id,num_guesses,secret_number) VALUES($USER_ID,$COUNT,$SECRET_NUMBER)" )

    fi
  fi
}

MAIN
