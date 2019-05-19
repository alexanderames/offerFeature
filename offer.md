<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

 - [Set up](#set-up)

  - [Application](#application)
  - [Database](#database)

- [Requirements and Implementation](#requirements-and-implementation)

  - [Define a JSON API for consumption by the client](#define-a-json-api-for-consumption-by-the-client)
  - [Build a single page application (SPA) using a JavaScript frontend framework or library](#build-a-single-page-application-spa-using-a-javascript-frontend-framework-or-library)
  - [Asynchronously request the data needed for your SPA from your Rails API](#asynchronously-request-the-data-needed-for-your-spa-from-your-rails-api)
  - [Display all offers in a gallery view](#display-all-offers-in-a-gallery-view)
  - [Display an individual offer in a detail view](#display-an-individual-offer-in-a-detail-view)
  - [Application is well tested](#application-is-well-tested)

    - [Initial tests](#initial-tests)

  - [Provide code in a private git repo (hosted or in an archive)](#provide-code-in-a-private-git-repo-hosted-or-in-an-archive)

<!-- /TOC -->

 ===

# Overview

Send the offer data (more details below) from the database to the browser as JSON and then display the offers in the browser as a single page application.

# Set up

## Application

```
bundle install
rake db:migrate
rake db:test:prepare
rake db:seed
```

## Database

This application uses SQLite with ActiveRecord.

The tables given to you are stored in the .seed.csv files, and are loaded to your local SQLite database by the command `rake db:seed`

--------------------------------------------------------------------------------

# Requirements and Implementation

Below are the Requirements listed and the corresponding Implementation I used:

## Define a JSON API for consumption by the client

I will be using GraphQL because it is a clear, concise way to emit JSON data. Before I could do that though I needed to turn this Rails App into an API only application. I did this following [these steps](https://hashrocket.com/blog/posts/how-to-make-rails-5-api-only).

In order to see the JSON schema, run the server, go to <http://localhost:3000/graphiql>, and the schema is on the right-hand side.

## Build a single page application (SPA) using a JavaScript frontend framework or library

### React-Client

I built the frontend with `create-react-app` and stored it in the directory `react-client`. Then I installed Apollo to link the GraphQL queries with the server.

## Asynchronously request the data needed for your SPA from your Rails API

## Display all offers in a gallery view

## Display an individual offer in a detail view

## Application is well tested

Even though this is almost the last requirement, I believe it should be the first. When dropped into a brand new application, the easiest way to see how it works is by running the test suite and seeing what works(and how) and what possibly doesn't.

### Initial tests

Initial tests revealed that the rails_helper.rb and Gaurdfile needed to be accounted for, then: `No route matches {:action=>"index", :controller=>"home"}`. This is because routes.rb doesn't have a HomeController represented. I decided not to use that controller so both were deleted.

### Model tests

I flushed out the existing factories with the Faker gem. Then I created model associations in Offers, Retailers, and RetailerOffers spec. I did this using ShouldaMatchers gem.

## Provide code in a private git repo (hosted or in an archive)
