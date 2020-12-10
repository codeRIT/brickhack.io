# Runs build script so heroku-buildpack-static
# has a freshly compiled static site to work with.
rm -r build
npm install
npm run build
