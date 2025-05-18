# Use Ruby 3.0.0 as the base image
FROM ruby:3.0.0-slim

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    postgresql-client \
    git \
    curl \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Yarn using npm
RUN npm install -g yarn

# Set working directory
WORKDIR /app

# Install Rails dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Copy the rest of the application code
COPY . .

# Install JavaScript dependencies
RUN yarn install

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
