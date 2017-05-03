# DevOps Docker image

The purpose of this repository is to provide an opinionated example of how to create a "fat" DevOps Docker image.

## What is the purpose of this Docker image?
The purpose of this Docker image is for any application that you need to build, run tests, or any scripts, this image is your one stop shop.

## Why is the Docker image "fat"?
It is "fat" because it has everything that you need to fulfill the purpose of the image.

## Why use a "fat" Docker image instead a properly provisioned VM?
Given recent experiences, we've found the turn around time for creating a new VM from build to deploy, to be roughly around 15 min. The idea here, is that Docker images are relatively inexpensive to create and publish, which allows you to make changes and publish them quickly. 
