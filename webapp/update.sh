#!/bin/bash

echo "pulling code from master branch..."
git pull origin master

echo "precompiling assets..."
bundle exec rake assets:precompile

echo "running any database migrations..."
bundle exec rake db:migrate

echo "updating cronjobs..."
whenever -w

echo "restarting app..."
touch tmp/restart.txt

echo ""
echo "WooHoo! Live!"