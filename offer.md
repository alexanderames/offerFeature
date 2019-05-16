<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Set up](#set-up)
	- [application](#application)
	- [database](#database)

<!-- /TOC -->

 # Overview

Send the offer data (more details below) from the database to the browser as JSON and then display the offers in the browser as a single page application.

--------------------------------------------------------------------------------

# Set up

## application

```
bundle install
rake db:migrate
rake db:test:prepare
rake db:seed
```

## database

This application uses SQLite with ActiveRecord.

The tables given to you are stored in the .seed.csv files, and are loaded to your local SQLite database by the command `rake db:seed`
