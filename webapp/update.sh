#!/bin/bash

git pull origin master
bundle exec rake assets:precompile
touch tmp/restart.txt
