My Blog
=======

This is my blog which can be found at sudo-code.herokuapp.com

Useful Rails Commands
=====================

Basic Rails Commands
---------------------

### Create a new project

    $ rails new <project_name>

### Rails server

    $ rails server

or 

    $ rails s

### Rails server with debug

Requires to have rails-server inside your gemfile

    $ rails server --debug

Bundle Commands
---------------

### Install Bundles defined in Gemfile

    $ bundle install --without production

without production does not install production bundles (unnecessary for development environment)

### Generate Scaffold

A scaffold includes a number of files and settings to get you started with a resource, including routes and pages utilizing the REST architectural style and the corresponding CRUD operations (new, update(edit), read(show) and delete).

    $ rails generate scaffold <Model_singular_capitalized> column1:column_type column2:column_type ...

example:

    $ rails generate scaffold User username:string age:integer admin:boolean

### Generate Model

Just to generate model, without the controller, pages, etc:

### Generate Controller

Does not generate models/routes etc.  Just the controller with the defined actions

    $ rails generate controller <Name_plural_capitalized> action1 action2 etc... --no-test-framework

example

    $ rails generate controller StaticPages home help --no-test-framework

can append <tt>--no-test-framework</tt> to skip generating of default (empty) tests

### Run a migration for current environment

    $ bundle exec rake db:migrate

### Run a migration for unit tests

    $ bundle exec rake db:test:prepare

Github Commands
---------------

### Initialise local repository, add all files and create an 'Initial commit'

    $ git init
    $ git add .
    $ git commit -m "Initial commit"

### Add remote repository

You will need to create one in github first

    $ git remote add origin git@github.com:<username>/<appname>.git
    $ git push -u origin master

### Push to Github

    $ git push


Heroku
------

### Heroku Initial Setup and Initial Push

    $ heroku create --stack cedar
    $ git push heroku master

### Heroku push

    $ git push heroku

### View heroku logs 

Useful when you run into any problems

    $ heroku logs

RSpec Commands
--------------

### First configure rails to use rspec instead of Test::Unit

    $ rails generate rspec:install