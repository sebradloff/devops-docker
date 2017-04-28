FROM centos:7

# Install ruby and its dependencies
RUN yum install -y ruby
RUN gem install bundler rake rspec serverspec docker-api
