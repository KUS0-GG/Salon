#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "\nWelcome to My Salon, how can I help you?\n"
  fi

  echo -e "\n1) Wash\n2) Cut\n3) Style"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) WASH_MENU ;;
    2) CUT_MENU ;;
    3) STYLE_MENU ;;
    *) MAIN_MENU "I could not find that service. What would you like today?"
  esac
}

WASH_MENU() {
 echo "You have selected a wash, what is your phone number?"
 read CUSTOMER_PHONE
 
  #find customer name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if not found
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    # insert new customer info
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  fi
  #get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # ask for time
  echo -e "\nWhat time would you like your wash, $CUSTOMER_NAME?"
  read SERVICE_TIME

  # insert appointment details
  ADD_APPOINTMENT=$($PSQL "INSERT INTO appointments(time,service_id,customer_id) VALUES('$SERVICE_TIME','$SERVICE_ID_SELECTED','$CUSTOMER_ID')")

  # confirm information
  echo -e "\nI have put you down for a wash at $SERVICE_TIME, $CUSTOMER_NAME."
}

CUT_MENU() {
  echo "You have selected a cut, what is your phone number?"
  read CUSTOMER_PHONE

  #find customer name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if not found
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    # insert new customer info
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  fi
  #get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # ask for time
  echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
  read SERVICE_TIME

  # insert appointment details
  ADD_APPOINTMENT=$($PSQL "INSERT INTO appointments(time,service_id,customer_id) VALUES('$SERVICE_TIME','$SERVICE_ID_SELECTED','$CUSTOMER_ID')")

  # confirm information
  echo -e "\nI have put you down for a cut at $SERVICE_TIME, $CUSTOMER_NAME."
}

STYLE_MENU() {
  echo "You have selected a style, what is your phone number?"
  read CUSTOMER_PHONE
  
  #find customer name
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if not found
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    # insert new customer info
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  fi
  #get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # ask for time
  echo -e "\nWhat time would you like your style, $CUSTOMER_NAME?"
  read SERVICE_TIME

  # insert appointment details
  ADD_APPOINTMENT=$($PSQL "INSERT INTO appointments(time,service_id,customer_id) VALUES('$SERVICE_TIME','$SERVICE_ID_SELECTED','$CUSTOMER_ID')")

  # confirm information
  echo -e "\nI have put you down for a style at $SERVICE_TIME, $CUSTOMER_NAME."
}

MAIN_MENU
