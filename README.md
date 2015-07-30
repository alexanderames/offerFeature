Ibotta Dev Project
=========


# The Project
---
Follow the Ruby on Rails Setup instructions below and seed the database with the geolocation information. Then complete the following tasks:

__Task 1__ Implement JSON API endpoints to view seed data for the following scenarios.

    GET /events.json?retailer=3
    # Returns all events for a retailer

    GET /events.json?near=39.69,-104.94&radius=5
    # Returns all events within a 5 mile radius

    GET /events.json?near=39.69,-104.94&radius=5&retailer=3
    # API endpoint should be able to take any combination of GET params.

__Task 2__ Add a new table for receipts. The table should have the following information:
 * Retailer
 * Store
 * Customer
 * Total Amount
 * Total Items
 * Date/Time

__Task 3__ Implement an API to create a new receipt


__Task 4__ Include test/specs for API.


# Ruby on Rails Setup
---

This application requires:

* Ruby (1.9.3 or above. Currently setup for Ruby 2.1.2)
* Rails (4.1.1)

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Here's a quick install procedure for OSX Mavericks:

1. Ensure XCode and Command Line Tools are installed
2. Install [brew](http://brew.sh/)
3. Install the following brew packages

  ```sh
  brew install git node pcre rbenv ruby-build
  ```
  
4. Ensure your rbenv profile is setup per the instructions printed during brew install, and possibly restart your terminal
5. cd to the project root directory (where Gemfile is) and setup ruby

  ```sh
  cd [project_directory]
  rbenv install 2.1.2
  rbenv rehash
  gem install bundler
  ```
  
6. initialize the application

  ```sh
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

Gems/Frameworks that are included but not mandatory to use:
* Testing Framework: RSpec and Factory Girl
* Continuous Testing: Guard and Spring

# Database
---

This application uses SQLite with ActiveRecord.

The tables given to you are stored in the .seed.csv files, and are loaded to your local sqlite database by the command ```rake db:seed```

If you want to use another database (MySQL), you will need to [configure databases.yml](http://edgeguides.rubyonrails.org/configuring.html#configuring-a-database) and then load the data there.

The database consists of sample data for 4 tables - customers, retailers, stores and events. The associated basic Rails models are included in the RoR project. A few notes:
* Events are sample geolocation events for our customers (e.g. Enter geofence for a store location). ```event_at``` is the timestamp of when the geofence event was triggered on the mobile device. ```insert_dt``` is the timestamp of when the data was inserted into the database and can be ignored.
* Stores and events are bounded by roughly 30 miles around downtown Denver and are from roughly a 3 week timeframe. 
* Lat/long on customers is the latitude and longitude of their home zip code.
* You may ignore the offers and tasks data for the purposes of this project.


# Deliverable
---
Please provide the code for the assignment either in a private repository (GitHhub or Bitbucket) or as a zip file.
