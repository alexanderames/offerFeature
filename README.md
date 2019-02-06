Ibotta Dev Project (Web Engineer)
=========

The Project
---
Your goal is to send the offer data (more details below) from the
database to the browser as JSON and then display the offers in the
browser as a single page application.

### Requirements
 * [ ] Define a JSON API for consumption by the client
 * [ ] Build a single page application (SPA) using a JavaScript frontend framework or library
 * [ ] Asynchronously request the data needed for your SPA from your Rails API
 * [ ] Display all offers in a gallery view
 * [ ] Display an individual offer in a detail view
 * [ ] Application is well tested
 * [ ] Provide code in a private git repo (hosted or in an archive)

### Nice to have
 * [ ] Track offer views
 * [ ] Search for offers
 * [ ] Filter offers in the gallery by retailer
 * [ ] Display retailer info for an offer

### Documentation
Consider writing documentation that would be useful to maintainers of your application. Suggestions for documentation topics include:

* How to setup and run your application
* Implementation details (3rd party modules, build tooling, etc.)
* Design overview and trade-offs you considered
* Additional features you think would be useful
* Edge cases you found while working on the project

### Notes:

 * Image URLs for each offer are in the database.

Ruby on Rails
---

This application requires:

* Ruby (2.5.x)
* Rails (5.2.2)

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Here's a quick install procedure for OSX El Capitan:

1. Ensure XCode and Command Line Tools are installed
2. Install [brew](http://brew.sh/)
3. Install the following brew packages
```
#!sh
brew install git node pcre rbenv ruby-build sqlite3
```
4. Ensure your rbenv profile is setup per the instructions printed during brew install, and possibly restart your terminal
5. cd to the project root directory (where Gemfile is) and setup ruby
```
#!sh
cd [project_directory]
rbenv install 2.5.3
rbenv rehash
gem install bundler
```
6. Initialize the application
```
#!sh
bundle install
rake db:migrate
rake db:test:prepare
rake db:seed
```

Common rails commands:
* ```bundle exec guard``` automatically runs the rails server as well as runs tests when files change (run from top level of repo)
* ```rake db:seed``` will always reload the given test data (will take a while)
* ```rails console``` an interactive ruby console including the rails environment
* ```rails db``` an interactive database console

Getting a segfault on seed?
Sorry about that - it's a bug with macOS sierra. Run this to get it fixed:

```sh
  brew update
  brew install sqlite3
  gem pristine sqlite3
  spring stop
  rake db:seed
```

Database Setup
---

This application uses SQLite with ActiveRecord.

The tables given to you are stored in the .seed.csv files, and are
loaded to your local SQLite database by the command ```rake db:seed```

The database consists of sample data for 3 tables - offers,
retailers, and retailer_offers. These are sample offers from Ibotta.
The associated Rails models are included in the RoR project.

To gain a better understanding these models, feel free to download
the Ibotta app and explore.

Gems/Frameworks Already Included
---
* Template Engine: Haml or ERB
* Testing Framework: RSpec and Factory Girl
* Front-end Framework: Twitter Bootstrap 3.0 (Sass, Javascript)
* Continuous Testing: Guard and Spring
