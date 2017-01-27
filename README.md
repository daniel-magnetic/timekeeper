# README

This app is a toy implementation of the timekeeper rest api from https://gist.github.com/anaqvi15/3902991918e3e4b0b4dcc754c0bba74c

assuming ruby and rubygems and bundler are available on the system:

`bundle install`

`rails db:setup`

`rails s`

## Ruby version

Ruby >2.3

## System dependencies

no dependencies beyond gemfile and of course a ruby environment

sqlite is used for the database for ease of use

## Configuration

default config is in the repo for easy of use. they can be left out of repo and replaced with *.example if they start to contain secrets or to support different environments

## Database creation

Uses sqlite so to create the file and init structure do:
>rails db:setup
it includes some seed data so you can browse a non empty index from the start

## How to run the test suite

`rails test`

## Services (job queues, cache servers, search engines, etc.)

none of these things are used or enabled in this toy

## Deployment instructions

nope. just clone and rails s

## Design decisions

The assumption based on the spec is that TimeCards have 0-2 TimeEntries since this is just a toy app. A later extension would be to work with multiple pairs of time entries instead of a max of 1 pair. There are some possible race conditions with the implementation (of max 2) so better care could be taken to lock records.

More care can be take in tailoring the db fields to make use of non nulls and better choices can be made on disabling timestamps with future cache implications. Even referential integrity and nullability can be considered.

Assumes username has to be unique and fields are required not null so those validations were added with some tests.

It looks like the only real business logic that is to be implemented beyond what rails can generate is to make time entries interact in pairs with time card total hours.

json response format could be better structured with more info to some other standard. for example, a link to each resource returned.

nothing fancy was done with generators (or manually) to namespace controllers for api versioning. but that could be something to think about.
