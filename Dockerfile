# Use an official Ruby runtime as a parent image
FROM ruby:3.1.2

# Install Node.js (Version 16.x)
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Install Yarn
RUN npm install -g yarn

# Install dependencies
RUN apt-get update -qq && apt-get install -y sqlite3 libsqlite3-dev

# Set environment to production
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Set an environment variable where the Rails app is installed to inside of Docker image
ENV INSTALL_PATH /myapp
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install --binstubs --jobs 20 --retry 5

# Ensure the node packages are installed
COPY package.json package.json
COPY package-lock.json package-lock.json
RUN npm install --check-files

# Copy the main application.
COPY . .

# Precompile Rails assets
RUN bundle exec rake assets:precompile

# Expose a volume so that nginx will be able to read in assets in production
VOLUME ["$INSTALL_PATH/public"]

# Expose port 3000 to the Docker host, so we can access it from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
