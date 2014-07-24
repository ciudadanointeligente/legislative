#!/bin/bash

set -e

export FORCE=false
args=`getopt f`
for i
do
  case "$i" in
        -f) FORCE=true;;
  esac
done

export DIR=writeit_local_for_testing
export VIRTUALENV=writeit_for_testing
export WHERE_YAMLS_ARE="../writeit_for_testing/"

if [ ! $1 ]
	then
	export YAML_FILE_NAME="writeit_example_data.yaml"
else
	export YAML_FILE_NAME="$1"
fi
export YAML_FILE=${WHERE_YAMLS_ARE}${YAML_FILE_NAME}
cd $DIR;
source $VIRTUALENV/bin/activate;

if [ ! -e current_data.txt ]; then touch current_data.txt; fi

CURRENT_DATA=`cat current_data.txt`;

if [[ FORCE || "$CURRENT_DATA" != "$YAML_FILE_NAME" ]]
then
        echo "$CURRENT_DATA y $YAML_FILE_NAME no son iguales";
        echo "$YAML_FILE_NAME" > current_data.txt;
        python manage.py flush --noinput
        python manage.py loaddata $YAML_FILE;
        
else
        echo "$CURRENT_DATA y $YAML_FILE_NAME son iguales";
fi