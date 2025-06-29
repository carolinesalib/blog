FROM ruby:3.0.0-slim

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    curl \
    git \
    postgresql-client \
    libpq-dev

# Install Node 16 and Yarn (Webpacker compatible versions)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

# Set working directory
WORKDIR /app

# ENV RAILS_ENV=production
# ARG RAILS_MASTER_KEY
# ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY

# Install Rails dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Copy app code
COPY . .

# Install JS dependencies
RUN yarn install

# Precompile assets (commented out - will be done at runtime)
# RUN bundle exec rails assets:precompile

# Create tmp/pids directory for Puma PID file
RUN mkdir -p tmp/pids

# Expose port
EXPOSE 3000

# Start Puma directly (with asset precompilation)
CMD ["sh", "-c", "bundle exec rails assets:precompile && bundle exec puma -C config/puma.rb"]

# Docker Healthcheck for Kamal
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl --fail http://localhost:3000/up || exit 1
