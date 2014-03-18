# Sinatra-Heroku application to store company contact info

![Build Status](https://www.codeship.io/projects/0896f0a0-8b65-0131-889b-0e06082247a9/status)

[![Coverage Status](https://coveralls.io/repos/mogensen/company-database/badge.png?branch=master)]
(https://coveralls.io/r/mogensen/company-database?branch=master)

## Documentation

The JSON API for the company database application is documented in API Blueprint langurage
- a superset of markdown.

[Se the blueprint here](https://github.com/mogensen/company-database/blob/master/apiary.apib)
or the rendered version with examples at [apiary](http://docs.companydatabase.apiary.io/)

## Getting startet

 1. Clone this repository
 2. Change directory into the newly cloned dir.
 3. Run `bundle install`
 4. To start the application run `bundle exec rackup`
 5. Goto `http://localhost:9292` to interact with the ember frontend.
 
## Running unit test

To run the unit tests locally run `bundle exec rspec .`

There is tests for all `GET`, `PUT`, `DELETE` and `POST` routes, and tests for
all error codes that can result from wrong usage of the API.
