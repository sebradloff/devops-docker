FROM alpine:3.5

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-bundler
ENV JAVA_PACKAGES openjdk8-jre-base

# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    apk add $JAVA_PACKAGES && \
    rm -rf /var/cache/apk/*

# Set JAVA_HOME for applications at run time
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk
# Set JAVA_HOME for all users
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk" > /etc/profile.d/java_home.sh

# Create app-code space
RUN mkdir -p app-code
COPY . /app-code

# Install neccessary gems for testing
RUN bundle install --gemfile=/app-code/tests/Gemfile
