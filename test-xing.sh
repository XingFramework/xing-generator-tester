#!/bin/bash
set -e

RUBY_VERSION=${RUBY:="2.2.3"}
PROJECT_NAME=$1

# Optionally leverage RVM to test in an empty gemset
if [ "${2}" = "--rvm" ]
then
  export PATH="$HOME/.rvm/bin:$PATH"
  source ~/.rvm/scripts/rvm
  rvm use $RUBY_VERSION
  rvm gemset create $PROJECT_NAME
  rvm use $RUBY_VERSION@$PROJECT_NAME

  # needed for 'xing new' CLI tool, until it is a published gem.
  # gem install trollop caliph # this shouldn't be needed?
fi

xing new --ruby-version=$RUBY_VERSION $PROJECT_NAME

if [ "${2}" = "--rvm" ]
then
  echo $PROJECT_NAME > $PROJECT_NAME/.ruby-gemset
  echo $PROJECT_NAME > $PROJECT_NAME/backend/.ruby-gemset
  echo $PROJECT_NAME > $PROJECT_NAME/frontend/.ruby-gemset
fi


echo Simulating user\'s first setup in new project
cd $PROJECT_NAME
cp backend/config/secrets.yml.example backend/config/secrets.yml
cp backend/config/database.yml.example backend/config/database.yml
if [ -n $POSTGRES_USER ]; then
  sed -i "s|# username: postgres|username: ${POSTGRES_USER}|" < backend/config/database.yml.example > backend/config/database.yml
fi
sed -i  's/# database: CHANGEME.*/database: xingtest/' backend/config/database.yml

cd backend
rake db:create
cd ..

echo Running full spec suite
if bundle exec rake spec:full
then
  printf "\e[0;32m %s \e[0m\n" 'SUCCESS!'
  echo Proceed to examine result in $PROJECT_NAME
else
  printf "\e[0;31m %s \e[0m\n" 'FAILURE!'
fi
