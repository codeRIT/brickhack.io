# brickhack.io

[![Build Status](https://travis-ci.org/codeRIT/brickhack.io.svg?branch=develop)](https://travis-ci.org/codeRIT/brickhack.io)
[![View Performance Data on Skylight](https://badges.skylight.io/status/qJBgRrLwFH2L.svg)](https://oss.skylight.io/app/applications/qJBgRrLwFH2L)
[![Code Climate](https://codeclimate.com/github/codeRIT/brickhack.io/badges/gpa.svg)](https://codeclimate.com/github/codeRIT/brickhack.io)
[![Test Coverage](https://codeclimate.com/github/codeRIT/brickhack.io/badges/coverage.svg)](https://codeclimate.com/github/codeRIT/brickhack.io/coverage)
[![security](https://hakiri.io/github/codeRIT/brickhack.io/develop.svg)](https://hakiri.io/github/codeRIT/brickhack.io/develop)

The public facing website for BrickHack.

**Registration + management site: [hackathon_manager](https://github.com/codeRIT/hackathon_manager)**

# Getting Started

#### Code environment

Ensure you have Git set up and [SSH access to GitHub](https://help.github.com/articles/connecting-to-github-with-ssh/). If you have Git but not SSH, you can clone using the HTTPS url, however you'll have to type in your GitHub credentials every time.

```bash
$ git clone git@github.com:codeRIT/brickhack.io.git
$ cd brickhack.io
```

You should then be able to open the code in your editor of choice.

#### Spin up the services locally

1. Download & install [Docker](https://www.docker.com/community-edition#/download)
2. Open/start Docker
3. Once docker is started, build & bring up the website:
```bash
docker-compose up --build
```
5. You should now be able to access the website at http://localhost:3000
_**Windows users:** be sure to accept the security pop-ups - they might be hidden! The website will not start until you accept them._

#### Running tests

Tests validate all of our pages load correctly.

1. Copy the sample environment variables (`cp .env.sample .env`)
2. Run the test suite using Docker:
```bash
docker-compose run web rails test
```

### Browser Testing

Thanks to [BrowserStack's open source program](https://www.browserstack.com/open-source), we have access to cross-browser testing! We test for cross-browser compatibility with BrowserStack's Live product. Talk to a maintainer to gain access to our account.

[<img src="public/browserstack.png" height="50" alt="BrowserStack Logo" />](public/browserstack.png)

## Docker Tooling

* If you need to restart the Rails server:
```bash
docker-compose restart web
```
* If you need to make changes to the Gemfile:
```bash
# 1. Make your changes to Gemfile
# 2. Run a `bundle install` to update the Gemfile.lock
docker-compose run web bundle install
# 3. Update the "web" docker image
docker-compose build web
# 4. Start the new container.
#    If `docker-compose up` isn't already running, exclude "-d"
docker-compose up -d web
```
* If you make a change to the Gemfile, such as for installing a new gem:
```bash
docker-compose run web bundle install
docker-compose restart web
```
* If you need to update a gem:
```bash
docker-compose run web bundle update the-gem
docker-compose restart web
```

You can follow the same format for `db` and `redis`, though you shouldn't ever need to restart those.

# Development & Deployment

All development work should be done locally in a new branch and/or fork. Then, make a pull request to have the code merged into the develop branch. Once the develop branch gets to a good state, it gets merged into the master branch for a production deployment.

Code pushed to any `codeRIT/brickhack.io` branch will automatically build on [Travis CI](https://travis-ci.org/codeRIT/brickhack.io) for tests. Any build on the develop or master branches will also trigger a deploy to our instance(s) of [Dokku](https://github.com/progrium/dokku) - staging for develop, production for master. Performance data of the production environment is available on [Skylight](https://oss.skylight.io/app/applications/qJBgRrLwFH2L).

See the [Production Environment Setup](https://github.com/codeRIT/brickhack.io/wiki/Production-Environment-Setup) page for details.
