# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

require 'csv'

Offer.delete_all
CSV.foreach(Rails.root.join('db','offers.seed.csv').to_s, headers: true) do |row|
  Offer.create!(row.to_hash)
end

Task.delete_all
CSV.foreach(Rails.root.join('db','tasks.seed.csv').to_s, headers: true) do |row|
  Task.create!(row.to_hash)
end

Retailer.delete_all
CSV.foreach(Rails.root.join('db','retailers.seed.csv').to_s, headers: true) do |row|
  Retailer.create!(row.to_hash)
end

Store.delete_all
CSV.foreach(Rails.root.join('db','stores.seed.csv').to_s, headers: true) do |row|
  Store.create!(row.to_hash)
end

Customer.delete_all
CSV.foreach(Rails.root.join('db','customers.seed.csv').to_s, headers: true) do |row|
  Customer.create!(row.to_hash)
end

Event.delete_all
CSV.foreach(Rails.root.join('db','events.seed.csv').to_s, headers: true) do |row|
  Event.create!(row.to_hash)
end
