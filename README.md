# ayanami

## Wtf is this?

Modern web interface for hlstatsx DB, written in ruby.
My instance on http://beta.melkor217.tk is now probably available
for inspection.

## Roadmap

- Write less ugly looking replacement for hlstatsx web
    - Make it show a lot of data
    - Make it fancy
- Implement compatable MongoDB models
- Replace hlstatsx daemon with a cool new one

## How to create schema?

`bundle exec rake db:create db:structure:load db:migrate`

I currently use db:seed to fill the database with fixture data.
If you are not planning to use current schema with real users, feel free to
do it as well. So, schema command would look like:

`bundle exec rake db:create db:structure:load db:migrate db:seed`

## Sad things

- CSGO is still the only game supported
- There is still no unit tests :(

## How to set it up?

### Basic things

Ayanami has following requirements:

- Ruby and required gems
- Access to hlstatsx database
- Redis server, optionally

So, how to install it:

- Ensure that you have hlstatsx MySQL database or just a fresh DB at least
- Download source code
- Install required libs and tools. List for debian-based systems:

   `sudo apt-get install -y cron git ruby bundler zlib1g-dev libmysqlclient-dev libsqlite3-dev mysql-client wget curl`
- Run `bundle install` from a source tree
- Set env variable `RAILS_ENV=production` (or something)
- Set mysql password in config/database.yml in production section
- Disable redis support by switching config.cache_store from :redis_store to :memory_store
  in config/environments/procution.db, or configure a redis server otherwise :)
- If you still don't have DB schema, run `rake db:create db:structure:load db;migrate`. If you want to fill it with fixture data,
also run `rake db:seed`
- Ensure that hlstatsx daemon uses the right database
- Run `rails s -e production`
- Check out localhost:3000

Setup process is a bit tricky, so i would recommend using this with docker

### Docker

Ayanami is easy to set up with docker-compose. You basically need only four things:

- docker and docker-compose installed
- directory to store mysql data
- source code tree (from zip archive or git)
- randomly chosen password for a DB and CSRF token

So, step-by-step guide:

0) Ensure that your user is allowed to run docker
1) Download source code tree and `cd` to it
2) Copy `Dockerfile.production.example` to `Dockerfile.production`, then replace MYSQL_PASSWORD and SECRET_KEY_BASE with
   their real values in it
3) Create a directory for MySQL persistent data. I use `/srv/ayanami/mysql` for it in my example
4) Copy `Dockerfile.mysql.example` to `Dockerfile.mysql`, then replace MYSQL_ROOT_PASSWORD with your password
(it should same with MYSQL_PASSWORD). Replace `/srv/ayanami/mysql` with a choosen mysql directory, otherwise ensure that
it exists
6) Run `docker-compose up ayanami-production`. Add `-d` flag if you want to daemonize it. It should create three
  containers. You can inspect them, check logs etc with `docker-compose` commands.
7) Check out http://localhost:3456
8) Database is also accessable on localhost:13306 with root/chosen_password

If you want to switch your hlstatsx stuff to dockerized database completely, you should:

* Make an sql dump with `mysqldump`. Let's call it `dump.sql`
* Ensure that dockerized schema is empty and exists: `docker-compose exec ayanami-production rake db:drop db:create`
(you should run this command from a source tree)
* run `docker-compose exec ayanami-mysql mysql -p ayanami < dump.sql ` or
`mysql -h 127.0.0.1 -P 13306 -u root -p ayanami < dump.sql` to restore dump
* Reconfigure you hlstatsx daemon to use new database URL
