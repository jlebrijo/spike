FROM ruby:2.6.3
MAINTAINER jlebrijo@gmail.com

# Preparing OS
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -

RUN  apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client nodejs yarn && \
     apt-get install -y vim imagemagick chromium

# Work folder
RUN mkdir -p /app
WORKDIR /app

# Packaging bundle and all assets
RUN gem install bundler
COPY Gemfile Gemfile.lock package.json yarn.lock ./
RUN bundle install --verbose --jobs 20 --retry 5
RUN yarn install --check-files
COPY . ./
RUN rake assets:precompile

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
