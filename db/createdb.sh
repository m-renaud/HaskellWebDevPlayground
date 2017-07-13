#!/bin/bash

# This script assumes that you have Postgres installed locally, with the
# admin user 'postgres'.

PLAYGROUND_DATABASE_NAME="playgroundDb"

createdb --host=localhost --username=postgres --owner=$USER \
	 ${PLAYGROUND_DATABASE_NAME}

psql --username=$USER --file=createUserTable.sql \
     --dbname=${PLAYGROUND_DATABASE_NAME}
