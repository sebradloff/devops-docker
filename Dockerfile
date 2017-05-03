FROM alpine:3.5

# Make difference clear between build and and ruby dependencies
ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-bundler

# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

# Create app-code space
RUN mkdir -p app-code
COPY . /app-code

# Install neccessary gems for testing
RUN bundle install --gemfile=/app-code/tests/Gemfile
