#!/bin/bash

set -e
export RAILS_VERSION=3.2.0

# this script will fetch a copy of billit and start it running locally.
# Assumes that ruby 2.0 is installed, and that mongodb is running locally and allows
# databases to be created without auth.
#
# Requirements for a RedHat/CentOS/Fedora machine:
# $sudo yum install solr3
#
# This is not a robust way to run the api, it is intended for local dev and for
# testing on travis-ci.


# just checkout the production branch
# http://stackoverflow.com/a/7349740/5349
export DIR=billit_local_for_testing
export BRANCH=production
export REMOTE_REPO=https://github.com/ciudadanointeligente/bill-it.git
export PORT=3003

if [ ! -e $DIR ]; then mkdir $DIR; fi
cd $DIR;

# If needed clone the repo
if [ ! -e done.txt ]; then
  git init;
  git remote add -t $BRANCH -f origin $REMOTE_REPO;
  git checkout $BRANCH;

  # set up the environment
  mkdir vendor/gems

  # rvm gemdir
  # rvm gemset name
  # rvm gemset list


  bundle install --path vendor/gems
  gem install activeresource -v 3.2.13

  cp config.ru.example config.ru
  cp config/sunspot.yml.example config/sunspot.yml
  cp config/mongoid.yml.example config/mongoid.yml
  cp config/hateoas.yml.example config/hateoas.yml
  mkdir -p log
  sed -i 's/development.site.org/127.0.0.1.xip.io:3003/g' config/hateoas.yml

  touch done.txt;
else
  git pull origin $BRANCH
  bundle install
fi


# Run the server in the background. Send access logging to file.
bundle exec rake sunspot:solr:start
bundle exec rails s -p $PORT > billit_access.log &

if [ ! -e done_post.txt ]; then
  sleep 5
  curl -H "Content-Type: application/json" --data @../mocks_for_billit/2282-03.json http://127.0.0.1.xip.io:3003/bills
  curl -H "Content-Type: application/json" --data @../mocks_for_billit/6967-06.json http://127.0.0.1.xip.io:3003/bills
  curl -H "Content-Type: application/json" --data @../mocks_for_billit/7000-24.json http://127.0.0.1.xip.io:3003/bills
  curl -H "Content-Type: application/json" --data @../mocks_for_billit/8438-07.json http://127.0.0.1.xip.io:3003/bills
  curl -H "Content-Type: application/json" --data @../mocks_for_billit/8578-24.json http://127.0.0.1.xip.io:3003/bills
  curl -H "Content-Type: application/json" --data @../mocks_for_billit/9007-03.json http://127.0.0.1.xip.io:3003/bills

  touch done_post.txt;
fi

# give it a chance to start and then print out the url to it
sleep 2
echo "Service should now be running on http://localhost:$PORT/bills/"
