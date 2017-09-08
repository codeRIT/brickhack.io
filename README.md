# brickhack.io  [![Build Status](https://travis-ci.org/codeRIT/brickhack.io.svg?branch=develop)](https://travis-ci.org/codeRIT/brickhack.io) [![Code Climate](https://codeclimate.com/github/codeRIT/brickhack.io/badges/gpa.svg)](https://codeclimate.com/github/codeRIT/brickhack.io) [![Test Coverage](https://codeclimate.com/github/codeRIT/brickhack.io/badges/coverage.svg)](https://codeclimate.com/github/codeRIT/brickhack.io/coverage) [![security](https://hakiri.io/github/codeRIT/brickhack.io/develop.svg)](https://hakiri.io/github/codeRIT/brickhack.io/develop)

The public facing site for BrickHack.

* **Hacker applications:** Users sign up/in using [MyMLH](https://my.mlh.io/), which includes standard hackathon application info. This pre-fills the BrickHack application, so hackers don't have to duplicate information!
* **Acceptance, RSVPs**: Manage applications & coordinate acceptance/waitlist/denials
* **Bus Lists:** Coordinate bus sign-ups during the RSVP process while communicating important information to riders & captains
* **Email communication**: Ensure hackers get consistent, timely information throughout their application process, while enabling the organizing team to communicate important information at any time.
* **Statistics & Visualization:** Surface key information about the application base, distribution of applicants, progress towards attendance, etc.

# Getting Started

## macOS

Install ruby, mysql, and other required development environment tools via [homebrew](https://brew.sh/).
```bash
$ brew install rbenv ruby-build rbenv-binstubs
$ brew install redis
$ brew install mysql
```

Ensure you have Git set up and [SSH access to GitHub](https://help.github.com/articles/connecting-to-github-with-ssh/). If you have Git but not SSH, you can clone using the HTTPS url, however you'll have to type in your GitHub credentials every time.

Download & configure local environment, [vendor everything](http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/) style.
```bash
$ git clone git@github.com:codeRIT/brickhack.io.git
$ cd brickhack.io
$ rbenv install
$ bin/setup
```

Optionally, you can use [Pow](http://pow.cx) to host your local development environment. This enables you to use [http://brickhack.io.dev/](http://brickhack.io.dev/) as your local URL, without having to manually run `rails server`.
```bash
$ brew install pow
$ gem install powder
$ powder link
```
Afterwards, you can restart the server with `powder restart`  when needed.

If you choose not to use Pow, you can still initiate a local Rails server with `bin/rails server` and visit [http://localhost:3000](http://localhost:3000)

### Possible Errors you may encounter

* You may encounter an error initially with an output like
```
While executing gem ... (Gem::FilePermissionError)
    You don't have write permissions for the /Library/Ruby/Gems/2.0.0 directory.
```
If encountered run
```bash
$ brew install ruby
$ rbenv install
```
Although it may say 
```
rbenv: /Users/../.rbenv/versions/2.4.1 already exists
continue with installation? (y/N) 
```
Enter y for yes because there is a chance that rbenv was not installed correctly initially

---

* If encountering errors when starting up your server and going on [http://localhost:3000](http://localhost:3000) with the error:
Can't connect to local MySQL server through socket '/tmp/mysql.sock'
run 
```bash
$ mysql.server start
```
Afterwards you may encounter an error: 
ActiveRecord::NoDatabaseError - Unknown database 'brickhack'
rerun 
```bash
$ bin/setup
```
With that you should now be able to go on to [http://localhost:3000](http://localhost:3000)


## Windows

***Note:*** *This setup is outdated. Contributions welcome!*

Verify you have a unix console emulator. We recommend the full version of [cmder](http://bliker.github.io/cmder/).

Download & install RailsInstaller from [http://railsinstaller.org/](http://railsinstaller.org/). Use the latest version.

Download & install redis from [https://github.com/rgl/redis/downloads](https://github.com/rgl/redis/downloads)

Download & configure local environment, [vendor everything](http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/) style.
```bash
$ git clone git@github.com:codeRIT/brickhack.io.git
$ cd brickhack.io
$ bin/setup
```

Start your local environment: `bin/rails server`

## Authenticaiton & Admin Testing

Authenticaiton is performed through [MyMLH](https://my.mlh.io). To access the admin pages, you'll need to create a local account & add our test MyMLH credentials.

1. Copy the sample environment variables (`cp .env.sample .env`)
2. Replace the values in `.env` with our test MyMLH credentials. *Contact a contributor to obtain these.*
2. Start up the local server (`bin/rails server`)
3. Visit `/manage` and sign in. You'll be asked to sign up or sign in to MyMLH, and authorize the applicaiton. Upon doing so, you'll be redirected back to your local server.
4. Start up the Rails console (`bin/rails console`) and run the following command:
```ruby
User.last.update_attribute(:admin, true)
```
5. You should now be able to access `/manage` (with `bin/rails server` still running)

## Development Utilities

* **Mail View** - Email templates can be previewed at http://localhost:3000/rails/mailers
* **Mail Catcher** - When active, emails will be captured by MailCatcher instead of slipping into a black hole (no emails are ever sent in development). Visit [mailcatcher.me](http://mailcatcher.me/) and follow instructions under "How" to get setup. **Note:** in order for mail to be sent, you must start a local Sidekiq worker using `bundle exec sidekiq`.
* **Guard** - Automatically runs tests based on the files you edit. `bundle exec guard`
* **Coverage** - Test coverage can be manually generated via the `bin/rails coverage:run` command. Results are then made available in the `coverage/` directory.
* **Sidekiq** - Run background jobs (such as emails) and view active & completed jobs. Spin up Sidekiq with `bundle exec sidekiq`. A web portal will be available at http://localhost:3000/sidekiq (*also available in production*).

# Development & Deployment

All development work should be done locally in a new branch and/or fork. Then, make a pull request to have the code merged into the develop branch. Once the develop branch gets to a good state, it gets merged into the master branch for a production deployment.

Code pushed to any `codeRIT/brickhack.io` branch will automatically build on [Travis CI](https://travis-ci.org/codeRIT/brickhack.io) for tests. Any build on the develop or master branches will also trigger a deploy to our instance(s) of [Dokku](https://github.com/progrium/dokku) - staging for develop, production for master. 

See the [Production Environment Setup](https://github.com/codeRIT/brickhack.io/wiki/Production-Environment-Setup) page for details.
