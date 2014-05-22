Ibotta Dev Project 20140521
=========

Ruby on Rails
---

This application requires:

* Ruby (1.9.3 or above. Currently setup for Ruby 2.1.2)
* Rails (4.1.1)

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Here's a quick install procedure for OSX Mavericks:

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
rbenv install 2.1.2
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


Database
---

This application uses SQLite with ActiveRecord.

The tables given to you are stored in the .seed.csv files, and are loaded to your local sqlite database by the command ```rake db:seed```

The database consists of sample data for 3 tables - retailers, stores and events. These are sample geolocation events from Ibotta.  The associated basic Rails models are included in the RoR project


The Project
---

Your goal is to use the geolocation event data to produce a heatmap, histogram over time, or some other representation of the location data.


Gems/Frameworks Already Included
---
* Template Engine: Haml or ERB
* Testing Framework: RSpec and Factory Girl
* Front-end Framework: Twitter Bootstrap 3.0 (Sass, Javascript)
* Continuous Testing: Guard and Spring