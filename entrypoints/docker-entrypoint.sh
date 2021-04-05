#!/bin/sh

# first option
#set -e
#
#if [ -f tmp/pids/server.pid ]; then
#  rm tmp/pids/server.pid
#fi

#bundle exec rails s -b 0.0.0.0 -p 3000 -e production



# second option
# Interpreter identifier

# Exit on fail
set -e

rm -f app/tmp/pids/server.pid
rm -f app/tmp/pids/sidekiq.pid

bundle exec rake db:create
bundle exec rake db:migrate

exec "$@"