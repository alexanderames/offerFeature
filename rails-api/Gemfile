source 'https://rubygems.org'
ruby '2.5.3'

gem 'rails', '~> 5.2'
gem 'sqlite3'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.5'
gem 'sdoc',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'figaro', :github=>"laserlemon/figaro"
gem 'haml-rails'
gem 'simple_form'
gem 'bootsnap', '>= 1.1.0', require: false
# The ruby implementation of the GraphQL language.
gem 'graphql'
gem 'search_object', '1.2.0'
gem 'search_object_graphql', '0.1'

group :development do
  # A development utility to test GraphQL queries.
  gem 'graphiql-rails'
  gem 'better_errors'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'html2haml'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails', '>= 3.0.0.beta2'
  gem 'rack-cors'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
end
