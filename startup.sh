#!/bin/bash
source .env

if [ "$RACK_ENV" == "production" ]; 
then 
  bundle install --without development test --path vendor/bundle
  bundle exec puma -C config/puma.rb
else
  bundle add shotgun
  bundle install --path vendor/bundle
  if [ "$RACK_ENV" == "test" ]; 
  then
    rspec
  else
    bundle exec shotgun -p 8000 -o '0.0.0.0' -O
  fi
fi
