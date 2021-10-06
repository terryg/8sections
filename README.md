# 8sections
Visualizing public data from the Commonwealth of Massachusetts.

https://www.8sections.org

## Getting Started

````
$ sudo apt update
$ sudo apt install libpq-dev postgresql-server-dev-13 ruby-dev -y
$ git clone git@github.com:terryg/8sections.git
$ cd 8sections
$ bundle install
$ echo "DATABASE_URL=postgres://localhost/database" > .env
$ bundle exec foreman run shotgun
````
