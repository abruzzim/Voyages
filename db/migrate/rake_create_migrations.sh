#!/bin/bash #-vx

set -e

# Filename:  rake_create_migrations.sh
# Directory: /Users/abruzzim/Documents/ga_wdi/project/planets
# Version:   1-002
# Date:      19-Dec-2013
# Author:    Mario Abruzzi
# Descript:  Create Rake Migration files for nasa_db HW
# Usage:     ./rake_create_migrations.sh [ astronauts | planets | moons ]

# Define Bash Symbols

faci="RAKE_CREATE_MIGRATIONS"

# Check for a valid P1

if [ "${1}" == "" ]; then
  seve="F"
  iden="NOP1"
  text="Null is not valid. Specify \"astronauts\", \"planets\" or \"moons\". Exiting Bash Script."
  echo ""
  echo "%${faci}-${seve}-${iden}, ${text}"
  echo ""
  exit 1
fi

if [ "${1}" != "astronauts" ] && [ "${1}" != "planets" ] && [ "${1}" != "moons" ]; then
  seve="F"
  iden="INVP1"
  text="Parameter \"${1}\" is not valid. Specify \"astronauts\", \"planets\" or \"moons\". Exiting Bash Script."
  echo ""
  echo "%${faci}-${seve}-${iden}, ${text}"
  echo ""
  exit 1
fi

# Rake planets_and_astronauts Migration Bash Menu

orig_PS3=$PS3 # Save the existing value of PS3

PS3="Select Option (RETURN to list all options): "
select option in "Create PSQL database \"nasa_db\"" \
                 "Create Rake Migration for \"astronauts\" table" \
                 "Create Rake Migration for \"planets\" table" \
                 "Create Rake Migration for \"moons\" table" \
                 "Create Rake Migration for \"voyages\" table" \
                 "Edit Project Files" \
                 "Run Rake Migration" \
                 "Display Columns in \"nasa_db\"" \
                 "Drop PSQL database \"nasa_db\"" \
                 "Help" \
                 "Quit"

do

  if [ "$REPLY" == "quit" ] || [ "$REPLY" == 11 ]; then
    # The 'break' must precede all other conditional checks.
    seve="I"
    iden="EXIT"
    text="Exiting Bash Script."
    echo ""
    echo "%${faci}-${seve}-${iden}, ${text}"
    echo ""
    break # Exit the loop.
  fi

  if [ "$REPLY" == "help" ]; then
    # User help section.
    echo "Create PSQL database \"nasa_db\"."
    echo "Create Rake Migration for \"astronauts\" table."
    echo "Create Rake Migration for \"planets\" table."
    echo "Create Rake Migration for \"moons\" table."
    echo "Create Rake Migration for \"voyages\" table."
    echo "Edit Project Files."
    echo "Run Rake Migration and then display tables."
    echo "Display All Columns in \"nasa_db\""
    echo "Drop PSQL database \"nasa_db\"."
    continue # Go back to the start of the loop.
  fi

  if [ ! -z "$option" ]; then # If the string is not zero length, then...

    echo "Option ${REPLY} was selected, which is ... "

    case $REPLY in
      1) echo "Creating PSQL database \"nasa_db\"..."
          psql --list
          psql --command="CREATE DATABASE nasa_db;"
          psql --list
          ;;
      2) echo "Creating Rake Migration for \"astronauts\" table..."
          rake db:create_migration NAME=create_table_astronauts
          #rake db:create_migration NAME=create_col_name_to_astronauts
          ;;
      3) echo "Creating Rake Migration for \"planets\" table..."
          rake db:create_migration NAME=create_table_planets
          #rake db:create_migration NAME=create_col_name_to_planets
          ;;
      4) echo "Creating Rake Migration for \"moons\" table..."
          rake db:create_migration NAME=create_table_moons
          #rake db:create_migration NAME=create_col_name_to_moons
          ;;
      5) echo "Creating Rake Migration for \"voyages\" table..."
          rake db:create_migration NAME=create_table_voyages
          #rake db:create_migration NAME=create_col_name_to_voyages
          ;;
      6) echo "Edit Project Files"
          subl "${PWD}"
          ;;
      7) echo "Run Rake Migration for \"nasa_db\"..."
          rake db:migrate
          psql --command="\d" nasa_db
          ;;
      8) echo "Display columns for \"nasa_db\"..."
          psql --command="SELECT * FROM astronauts;" nasa_db
          psql --command="SELECT * FROM planets;" nasa_db
          psql --command="SELECT * FROM moons;" nasa_db
          psql --command="SELECT * FROM voyages;" nasa_db
          ;;
      9) echo "Dropping PSQL database \"nasa_db\"..."
          psql --list
          psql --command="DROP DATABASE nasa_db;"
          psql --list
          ;;
    esac

  else

    seve="E"
    iden="INVOPT"
    text="${REPLY} is not a valid menu option."
    echo ""
    echo "%${faci}-${seve}-${iden}, ${text}"
    echo ""

  fi

done

PS3=$orig_PS3 # Restore the original value of PS3

exit 0
