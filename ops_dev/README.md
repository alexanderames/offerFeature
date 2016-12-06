# Ibotta DevOps Project

The goal of this project is to produce repeatable development and deployment solutions for a small web application.

## Part 1: Development Environment

1. Automate the setup of a local development environment to make it easy for new developers to get up and running quickly:
  - Install the correct version of Ruby (as defined by the `.ruby-version` file). Something like [rbenv](https://github.com/rbenv/rbenv) may be be helpful here.
  - Install required gems via [bundler](http://bundler.io/)
  - Install any other dependencies required by the application
1. After starting the app (i.e. `./app.rb`), you should be able to access it with a web browser at http://localhost:4567
1. Make sure all the unit tests pass. If a test fails, see if you can figure out what went wrong and fix it:

    ```
    $ rake test
    ```

## Part 2: Production Deployment

1. Using what you learned about the application in part 1, use a provisioning and deployment technology to create a repeatable deployment environment (e.g. in a Vagrant VM):
  - Puppet, Chef, Ansible, Salt, Rubber, OpsWorks/CodeDeploy are all acceptable examples
  - Instructions for initial install of any tools should be included
  - Docker use is acceptable, but this project will still need to cover provisioning/deployment and setting up docker 'from scratch' on new machine (images)
  - Pre-built images (Vagrant/AMI/etc) should not be included - this project should cover creating new images.
  - Note that the application is configurable via environment variables. Provide a way to configure the application for different environments (e.g. staging, production, etc.). The only required option for a production deployment is: `RACK_ENV=production`
1. Verify your work by making sure all the integration tests pass. Note that you can override the instance address and port by setting the `TARGET_HOST` and `TARGET_PORT` environment variables:

    ```
    $ TARGET_HOST=foo.example.com TARGET_PORT=8080 rake serverspec
    ```

## Deliverable

Please provide the code for the assignment either in a private repository (GitHhub or Bitbucket) or as a zip file. Instructions outside of the code should be provided in markdown readme files. Be prepared to run the deployment and walk through the steps it takes, and the decisions made while building.
