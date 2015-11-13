# brickhack.io  [![Build Status](https://travis-ci.org/codeRIT/brickhack.io.svg?branch=develop)](https://travis-ci.org/codeRIT/brickhack.io) [![Code Climate](https://codeclimate.com/github/codeRIT/brickhack.io/badges/gpa.svg)](https://codeclimate.com/github/codeRIT/brickhack.io) [![Test Coverage](https://codeclimate.com/github/codeRIT/brickhack.io/badges/coverage.svg)](https://codeclimate.com/github/codeRIT/brickhack.io/coverage)

The public facing site for Brick Hack.

# Getting Started

## Mac OS X

Install ruby, mysql, and other required development environment tools.
```bash
$ brew install rbenv ruby-build rbenv-readline rbenv-gem-rehash rbenv-default-gems rbenv-binstubs
$ brew install redis
$ brew install mysql
```

Download & configure local environment, [vendor everything](http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/) style.
```bash
$ git clone git@github.com:codeRIT/brickhack.io.git
$ cd brickhack.io
$ rbenv install
$ bundle install --path vendor --local
$ bundle exec rake db:create db:migrate
```

Optionally, you can use [Pow](http://pow.cx) to host your local development environment. With it, you can visit [http://brickhack.io.dev/](http://brickhack.io.dev/)
```bash
$ brew install pow
$ gem install powder
$ powder link
```
Afterwards, you can restart the server with `powder restart`  when needed.

If you choose not to use Pow, you can still initiate a local rails server with `bundle exec rails server` and visit [http://localhost:3000](http://localhost:3000)

## Windows

Verify you have a unix console emulator. We recommend the full version of [cmder](http://bliker.github.io/cmder/).

Download & install RailsInstaller 3.0 (alpha) from [http://railsinstaller.org/](http://railsinstaller.org/)

Download & install redis from [https://github.com/rgl/redis/downloads](https://github.com/rgl/redis/downloads)

Download & configure local environment, [vendor everything](http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/) style.
```bash
$ git clone git@github.com:codeRIT/brickhack.io.git
$ cd brickhack.io
$ gem install bundler
$ bundle install --path vendor --local
$ bundle exec rake db:create db:migrate
```

Start your local environment: `bundle exec rails server`

## Development Utilities

* **Mail View** - Email templates can be previewed at http://localhost:3000/mail_view/
* **Mail Catcher** - When active, emails will be captured by MailCatcher instead of slipping into a black hole (no emails are ever sent in development). Visit [mailcatcher.me](http://mailcatcher.me/) and follow instructions under "How" to get setup. **Note:** in order for mail to be sent, you must start a local Sidekiq worker using `bundle exec sidekiq`.
* **Guard** - Automatically runs tests based on the files you edit. `bundle exec guard`
* **Coverage** - Test coverage can be manually generated via the `bundle exec rake coverage:run` command. Results are then made available in the `coverage/` directory.

# Deployment

Code pushed will automatically build on [Travis CI](https://travis-ci.org/codeRIT/brickhack.io). Upon a successful build to the develop or master branches, Travis will deploy to our instance(s) of [Dokku](https://github.com/progrium/dokku). See the [Production Environment Setup](https://github.com/codeRIT/brickhack.io/wiki/Production-Environment-Setup) page for details.
