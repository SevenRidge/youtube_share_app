FROM ruby:2.7.1

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       apt-utils \
                       nodejs

RUN mkdir /railsapp
WORKDIR /railsapp

ADD Gemfile /railsapp/Gemfile
ADD Gemfile.lock /railsapp/Gemfile.lock

RUN bundle install

ADD . /railsapp

RUN mkdir -p tmp/sockets
