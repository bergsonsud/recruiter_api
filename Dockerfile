FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /recruiter_api

COPY Gemfile /recruiter_api/Gemfile
COPY Gemfile.lock /recruiter_api/Gemfile.lock

RUN gem update --system 3.3.22
RUN gem install bundler -v 2.3.22
RUN gem install ffi -v '1.17.0'
RUN bundle install

COPY . /recruiter_api
