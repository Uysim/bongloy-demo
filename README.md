# Bongloy Demo

[![Build Status](https://travis-ci.org/dwilkie/bongloy-demo.svg?branch=master)](https://travis-ci.org/dwilkie/bongloy-demo)

Bongloy-Demo is a Rails app which demonstrates how to use Bongloy. It includes the following features:
* Example of using Bongloy Checkout to capture the user's card details
* Example of using bongloy.js to create a custom form to capture the user's card details
* Example of and how to use [bongloy-ruby](https://github.com/dwilkie/bongloy-ruby) to create charges and customers from the server-side
* Testing Examples

## Live Demo

You can play with the live version at [https://bongloy-demo.herokuapp.com](https://bongloy-demo.herokuapp.com)

## Local Setup

### Clone or Fork the Repo

```shell
$ git clone https://github.com/dwilkie/bongloy-demo.git
```

### Set up Postgres

Create a new user `bongloy_demo` and give it `SUPERUSER` and `CREATEDB` privileges.

```shell
$ sudo -u postgres createuser bongloy_demo -s -d
```

Note, if `bongloy_demo` already exists but has insufficient privileges alter the role in psql.

```shell
$ sudo -u postgres psql
postgres=# ALTER ROLE bongloy_demo SUPERUSER CREATEDB;
postgres=# \dg
```

### Boot the development server

```shell
$ bundle exec foreman start web
```

### Sign up a test user

Navigate to "Sign in" then "Sign up" a new user
