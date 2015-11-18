# Ibotta Dev Project

The goal of this project is to produce a repeatable deployment solution for a small webapp.

## The Project

1. Create a small Ruby on Rails web app
  * Use [RailsComposer](https://github.com/RailsApps/learn-rails) for a quick template  `rails new learn-rails -m https://raw.github.com/RailsApps/rails-composer/master/composer.rb`
  * A similar node.js setup is also acceptible, but note that Ibotta heavily uses ruby
  * It should be easy to test the successful run of the server with a browser
1. Use a provisioning and deployment technology to create a repeatable deployment environment using Vagrant
  * Puppet, Chef, Ansible, Salt, Rubber, OpsWorks/CodeDeploy are all acceptable examples
  * Instructions for initial install of any tools should be included
  * Docker use is acceptable, but this project will still need to cover provisioning/deployment and setting up docker 'from scratch' on new machine (images)
  * pre-built images (Vagrant/AMI/etc) should not be included - this project should cover creating new images.
1. Add a database layer to the web app
  * Database should be simply used by the web app to show successful run
1. Add instructions on production deployment
  * It is not required to have app deployed to a production environment (EC2, etc).  Note that Ibotta is deployed in EC2
  * Configurations and instructions should include notes on how the app would be updated to deploy to production

Be prepared to run the deployment and walk through the steps it takes, and the decisions made while building.

### Optional tasks

1. Add a caching layer
  * redis, memcached
1. Add service discovery
  * could be as simple as managing DNS entries
1. Add load balancing
  * ELB or HAProxy

# Deliverable

Please provide the code for the assignment either in a private repository (GitHhub or Bitbucket) or as a zip file. Instructions outside of the code should be provided in markdown readme files.
