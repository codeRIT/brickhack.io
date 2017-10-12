FROM ruby:2.4.2

RUN apt-get update -qq && apt-get install -y build-essential

# for mysql
RUN apt-get install -y mysql-client

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
# RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime
RUN apt-get install -y nodejs

RUN mkdir /app
WORKDIR /app

ADD Gemfile* /app/
ADD .ruby-version /app/
RUN gem install bundler
RUN bundle install --jobs 20 --retry 5

ADD . /app
