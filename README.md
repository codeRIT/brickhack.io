# brickhack.io

[![Build Status](https://travis-ci.org/codeRIT/brickhack.io.svg?branch=develop)](https://travis-ci.org/codeRIT/brickhack.io)
[![View Performance Data on Skylight](https://badges.skylight.io/status/qJBgRrLwFH2L.svg)](https://oss.skylight.io/app/applications/qJBgRrLwFH2L)
[![Code Climate](https://codeclimate.com/github/codeRIT/brickhack.io/badges/gpa.svg)](https://codeclimate.com/github/codeRIT/brickhack.io)
[![Test Coverage](https://codeclimate.com/github/codeRIT/brickhack.io/badges/coverage.svg)](https://codeclimate.com/github/codeRIT/brickhack.io/coverage)
[![security](https://hakiri.io/github/codeRIT/brickhack.io/develop.svg)](https://hakiri.io/github/codeRIT/brickhack.io/develop)

The public facing site for BrickHack.

* **Hacker applications:** Users sign up/in using [MyMLH](https://my.mlh.io/), which includes standard hackathon application info. This pre-fills the BrickHack application, so hackers don't have to duplicate information.
* **Acceptance, RSVPs**: Manage applications & coordinate acceptance/waitlist/denials.
* **Bus Lists:** Coordinate bus sign-ups during the RSVP process while communicating important information to riders & captains.
* **Email communication**: Ensure hackers get consistent, timely information throughout their application process, while enabling the organizing team to communicate important information at any time.
* **Statistics & Visualization:** Surface key information about the application base, distribution of applicants, progress towards attendance, etc.

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
4. **In a new terminal window,** setup the database:
```bash
docker-compose run web rails db:setup
```
5. You should now be able to access the website at http://localhost:3000
_**Windows users:** be sure to accept the security pop-ups - they might be hidden! The website will not start until you accept them._

#### Running tests

Most core functionality is provided by [hackathon_manager](https://github.com/codeRIT/hackathon_manager), leaving this repo solely to surface the homepage (and any other pages). The main goal with this is to make sure every page loads successfully - there isn't too much else to test.

1. Copy the sample environment variables (`cp .env.sample .env`)
2. Run the test suite using Docker:
```bash
docker-compose run web rails test
```

## Authentication & Admin Testing

You'll want to make an account & promote yourself to an admin in order to access the entire website.

1. Visit http://localhost:3000/users/sign_up
2. Sign up for a regular account
3. Promote yourself to an admin:
```bash
docker-compose run web rails c
# Wait for the console to start...
Loading development environment (Rails 5.1.1)
irb(main):001:0> User.last.update_attribute(:admin, true)
```
5. You should now be able to access [`/manage`](http://localhost:3000/manage) (with `docker-compose up` still running)

#### MyMLH Authentication

Login is optionally available through [MyMLH](https://my.mlh.io). To use MyMLH locally, you'll need to create a local account & add test MyMLH credentials.

1. Copy the sample environment variables (`cp .env.sample .env`)
2. Replace the values in `.env` with our test MyMLH credentials. *Contact a contributor to obtain these, or [create your own app](https://my.mlh.io/docs).*
2. Start up the local server (`docker-compose up` or `docker-compose restart web`)
3. Visit [`/manage`](https://localhost:3000/manage) and sign in with MyMLH. You'll be asked to sign in to MyMLH and authorize the applicaiton. Upon doing so, you'll be redirected back to your local server.
4. Repeat [steps 3 & 4 from above](#authenticaiton-admin-testing).

## Development Utilities

* **Mail View** - Email templates can be previewed at http://localhost:3000/rails/mailers
* **Mail Catcher** - When active, emails will be captured by MailCatcher instead of slipping into a black hole (no emails are ever sent in development). Visit [mailcatcher.me](http://mailcatcher.me/) and follow instructions under "How" to get setup.
* **Guard** - Automatically runs tests based on the files you edit. `docker-compose run bundle exec guard`
* **Coverage** - Test coverage can be manually generated via the `docker-compose run web rails coverage:run` command. Results are then made available in the `coverage/` directory.
* **Sidekiq** - Run background jobs (such as emails) and view active & completed jobs. Sidekiq is automatically started with Docker - a dashboard is available at http://localhost:3000/sidekiq (*also available in production*).

## Docker Tooling

* If you need to restart the Rails server:
```bash
docker-compose restart web
```
* If you need to restart Sidekiq, the background job worker that handles emails:
```bash
docker-compose restart sidekiq
```
* If you need to make changes to the Gemfile:
```bash
# 1. Make your changes to Gemfile
# 2. Run a `bundle install` to update the Gemfile.lock
docker-compose run web bundle install
# 3. Update the "web" and "sidekiq" docker images
docker-compose build web sidekiq
# 4. Start the new containers.
#    If `docker-compose up` isn't already running, exclude "-d"
docker-compose up -d web sidekiq
```
* If you make a change to the Gemfile, such as for installing a new gem:
```bash
docker-compose run web bundle install
docker-compose restart web
```
* If you're working on the `hackathon_manager` locally:
```bash
# hackathon_manager should be cloned to the same folder above brickhack.io
git clone git@github.com:codeRIT/hackathon_manager.git ../hackathon_manager
# Start up services with the development config
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up
```
* If you need to update a gem, such as `hackathon_manager`:
```bash
# replace hackathon_manager with the gem's name
docker-compose run web bundle update hackathon_manager
docker-compose restart web
```

You can follow the same format for `db` and `redis`, though you shouldn't ever need to restart those.

# Development & Deployment

All development work should be done locally in a new branch and/or fork. Then, make a pull request to have the code merged into the develop branch. Once the develop branch gets to a good state, it gets merged into the master branch for a production deployment.

Code pushed to any `codeRIT/brickhack.io` branch will automatically build on [Travis CI](https://travis-ci.org/codeRIT/brickhack.io) for tests. Any build on the develop or master branches will also trigger a deploy to our instance(s) of [Dokku](https://github.com/progrium/dokku) - staging for develop, production for master. Performance data of the production environment is available on [Skylight](https://oss.skylight.io/app/applications/qJBgRrLwFH2L).

See the [Production Environment Setup](https://github.com/codeRIT/brickhack.io/wiki/Production-Environment-Setup) page for details.
