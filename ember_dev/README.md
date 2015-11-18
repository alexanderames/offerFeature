Ibotta Dev Project (Web Engineer)
=========

The Project
---
Your goal is to send the offer/task data (more details below) from the
database to the browser as JSON and then display the offers in the
browser as a single page Ember application.

### Requirements
 * [ ] Pull json data from the server
 * [ ] Display offers in a sorted gallery
 * [ ] View individual offer
 * [ ] Well tested
 * [ ] Provide code in a private git repo (hosted or in an archive)
 * [ ] Filter offers in gallery by Retailer
 * [ ] Display Retailer info on offers
 * [ ] Search for offers

### Nice to have
 * [ ] Track offer views
 * [ ] Implement task interactions for 1 or more task types

### Notes:

 * Image URLs for each offer are in the the database.
 * Task images can be be found in a sprite located in the app/assets/images directory.
 * The tasks do not need to be functional but should be shown along with each offer. You can ignore the content field for each task.


Ruby on Rails
---

This application requires:

* Ruby (1.9.3 or above. Currently setup for Ruby 2.1.5)
* Rails (4.1.1)

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Here's a quick install procedure for OSX El Capitan:

1. Ensure XCode and Command Line Tools are installed
2. Install [brew](http://brew.sh/)
3. Install the following brew packages
```
#!sh
brew install git node pcre rbenv ruby-build
```
4. Ensure your rbenv profile is setup per the instructions printed during brew install, and possibly restart your terminal
5. cd to the project root directory (where Gemfile is) and setup ruby
```
#!sh
cd [project_directory]
rbenv install 2.1.5
rbenv rehash
gem install bundler
```
6. initialize the application
```
#!sh
bundle install
rake db:migrate
rake db:test:prepare
rake db:seed
```

Common rails commands:
* ```guard``` automatically runs the rails server as well as runs tests when files change
* ```rake db:seed``` will always reload the given test data (will take a while)
* ```rails console``` an interactive ruby console including the rails environment
* ```rails db``` an interactive database console

Database Setup
---

This application uses SQLite with ActiveRecord.

The tables given to you are stored in the .seed.csv files, and are
loaded to your local sqlite database by the command ```rake db:seed```

The database consists of sample data for 4 tables - offers, tasks,
retailers, and retailer_offers. These are sample offers from Ibotta
along with the associated tasks (Facts, Videos, Polls, etc.). The
associated Rails models are included in the RoR project.

Gems/Frameworks Already Included
---
* Template Engine: Haml or ERB
* Testing Framework: RSpec and Factory Girl
* Front-end Framework: Twitter Bootstrap 3.0 (Sass, Javascript)
* Continuous Testing: Guard and Spring

