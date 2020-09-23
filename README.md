# brickhack.io

[![Build Status](https://travis-ci.com/codeRIT/brickhack.io.svg?branch=develop)](https://travis-ci.com/codeRIT/brickhack.io)

The public facing website for BrickHack.

**Registration + management site: [hackathon_manager](https://github.com/codeRIT/hackathon_manager)**

# Getting Started

## Code environment

Ensure you have Git set up and [SSH access to GitHub](https://help.github.com/articles/connecting-to-github-with-ssh/). If you have Git but not SSH, you can clone using the HTTPS url, but you'll have to type in your GitHub credentials every time.

### Cloning the directory

```bash
$ git clone https://github.com/codeRIT/brickhack.io.git
$ cd brickhack.io
```

### Installing dependencies

```
$ npm install
```

### Running the application

```
$ npm start
```

You should then be able to access the site at `localhost:3000`.

# Development & Deployment

All development work should be done locally in a new branch and/or fork. Then, make a pull request to have the code merged into the develop branch. Once the develop branch gets to a good state, it gets merged into the master branch for a production deployment.

Code pushed to any `codeRIT/brickhack.io` branch will automatically build on [Travis CI](https://travis-ci.org/codeRIT/brickhack.io) for tests. Any build on the master or develop branch will also trigger a deploy to GitHub Pages or our staging [Dokku](https://github.com/progrium/dokku) instance respectively.
