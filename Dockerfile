FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y build-essential

# https://github.com/nodesource/distributions#installation-instructions
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

# for mysql
# RUN apt-get install -y mysql-client

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
# RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime
RUN apt-get install -y nodejs

# Add app files into docker image
RUN mkdir -p /app
WORKDIR /app
COPY . .

# Add bundle entry point to handle bundle cache
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# Bundle installs with binstubs to our custom /bundle/bin volume path. Let system use those stubs.
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
