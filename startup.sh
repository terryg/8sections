#!/bin/bash
gem install bundler
gem install sinatra
gem install puma
source .env
if [ "$RACK_ENV" == "production" ]; 
then 
  bundle install --without development test
  bundle exec puma -C config/puma.rb
else
  bundle install
  if [ "$RACK_ENV" == "test" ]; 
  then
    rspec
  else
    gem install shotgun
    shotgun -I /usr/src/app $MAIN_APP_FILE -p 8000 -o '0.0.0.0'
  fi
fi
