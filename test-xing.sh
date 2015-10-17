#!/bin/bash --login

RUBY_VERSION=${RUBY:="2.2.3"}

# Optionally leverage RVM to test in an empty gemset
if [ "${2}" = "--rvm" ]
then
  export PATH="$HOME/.rvm/bin:$PATH"
  source ~/.rvm/scripts/rvm
  rvm use $RUBY
  rvm gemset create $1
  rvm use $RUBY@$1

  # needed for 'xing new' CLI tool, until it is a published gem.
  gem install trollop caliph
fi

xing new $1
echo $RUBY > $1/.ruby-version 
echo $RUBY > $1/backend/.ruby-version 
echo $RUBY > $1/frontend/.ruby-version 

if [ "${2}" = "--rvm" ]
then
  echo $1 > $1/.ruby-gemset
  echo $1 > $1/backend/.ruby-gemset 
  echo $1 > $1/frontend/.ruby-gemset
fi

cd $1
cp backend/config/secrets.yml.example backend/config/secrets.yml
cp backend/config/database.yml.example backend/config/database.yml
bundle
cd frontend && bundle
cd ../backend  && bundle
cd ..

bundle exec rake spec:full
if [ $? -eq 0 ]
then
  printf "\e[0;32m %s \e[0m\n" 'SUCCESS!'
else
  printf "\e[0;31m %s \e[0m\n" 'FAILURE!'
fi
