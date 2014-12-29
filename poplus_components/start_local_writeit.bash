#!/bin/bash

set -e

# this script will fetch a copy of writeit and start it running locally.
# Assumes that nodejs is installed, and that mongodb is running locally and allows
# databases to be created without auth.
#
# Requirements for a RedHat/CentOS/Fedora machine:
# $sudo yum install python-virtualenv
#
# This is not a robust way to run the api, it is intended for local dev and for
# testing on travis-ci.


# just checkout the master branch
# http://stackoverflow.com/a/7349740/5349
export DIR=writeit_local_for_testing
export BRANCH=master
export REMOTE_REPO=https://github.com/ciudadanointeligente/write-it.git
export PORT=3001
export VIRTUALENV=writeit_for_testing

if [ ! -e $DIR ]; then mkdir $DIR; fi
cd $DIR;

# If needed clone the repo
if [ ! -e done.txt ]; then
  git init;
  git remote add -t $BRANCH -f origin $REMOTE_REPO;
  git checkout $BRANCH;

  # set up the environment
  virtualenv $VIRTUALENV
  source $VIRTUALENV/bin/activate
  pip install -r requirements.txt
  pip install -r requirements_testing.txt
  python manage.py syncdb --noinput
  python manage.py migrate --noinput
  python manage.py loaddata ../mocks_for_writeit/example_with_2_messages.yaml

  touch done.txt;
else
  git pull origin $BRANCH
  source $VIRTUALENV/bin/activate
  pip install -r requirements.txt
fi


# Run the server in the background. Send access logging to file.
python manage.py runserver $PORT > writeit_access.log &

# give it a chance to start and then print out the url to it
sleep 2
echo "Service should now be running on http://localhost:$PORT/en/"
