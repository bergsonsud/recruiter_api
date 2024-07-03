#!/bin/sh

set -e

docker-compose build
docker-compose run --service-ports --rm -e "RAILS_ENV=test" web bin/rails db:create db:migrate
docker-compose run --service-ports --rm -e "RAILS_ENV=test" web bundle exec rspec