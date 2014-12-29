#!/bin/bash

set -e

# this script will fetch a copy of the popit-api and start it running locally.
# Assumes that nodejs is installed, and that mongodb is running locally and allows
# databases to be created without auth.
#
# Requirements for a RedHat/CentOS/Fedora machine:
# $sudo yum install mongo mongodb npm nodejs
#
# This is not a robust way to run the api, it is intended for local dev and for
# testing on travis-ci.


# just checkout the mysociety-deploy branch
# http://stackoverflow.com/a/7349740/5349
export DIR=popit_local_for_testing
export BRANCH=master
export REMOTE_REPO=https://github.com/lfalvarez/testing_popit_api.git
export PORT=3002

if [ ! -e $DIR ]; then mkdir $DIR; fi
cd $DIR;

# If needed clone the repo
if [ ! -e done.txt ]; then
  git init;
  git remote add -t $BRANCH -f origin $REMOTE_REPO;
  git checkout $BRANCH;
  npm install mongodb --quiet
  npm install mongodb-fixtures --quiet
  npm install --quiet

  cp ../mocks_for_popit/popit_api_initial_load.js .
  cp -R ../mocks_for_popit/fixtures .
  node popit_api_initial_load.js # initial data for popit

  touch done.txt;
fi


# Run the server in the background. Send access logging to file.
node server.js > popit_access.log &

# give it a chance to start and then print out the url to it
sleep 2
echo "API should now be running on http://localhost:$PORT/api"
