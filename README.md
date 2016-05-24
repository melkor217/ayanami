# ayanami

## Wtf is this?

Modern web interface for hlstatsx DB, written in ruby.
My instance on http://beta.melkor217.tk is now probably available
for inspection.

## Where to get hlstatsx itself?

It install instructions on https://bitbucket.org/Maverick_of_UC/hlstatsx-community-edition/wiki/Install .
You can get it's source code from that bitbucket repo. Also u'll need to get superlogs plugin form alliedmods.net
or somewhere. For csgo i would prefer to use hlstatsx and superlogs-csgo from noxus repo: https://github.com/laam4/noxus

## Roadmap

- Write less ugly looking replacement for hlstatsx web
    - Make it show a lot of data
    - Make it fancy
- Implement compatible MongoDB models
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

* Ensure that your user is allowed to run docker
* Download source code tree and `cd` to it
* Choose a directory where MySQL server will be store data and set it into docker-compose.yml.
 Ensure that directory exists and `mysql` user has write
 access to it (chmod 777 for sure, hehe). Default directory is `/srv/ayanami/mysql`.
* Do the same with redis directory (default value: `/srv/ayanami/redis`)
* If you have old MySQL data from hlx, just copy MySQL files (usually `/var/lib/mysql`) to that directory
* Copy `secrets.env.example` to `secrets.env`. Then edit it and set MySQL passwords up.
 If you've just uploaded MySQL data
 to directory, your username/password should have full access to specified database.
 Otherwise, specified database and user will be created
* Run `docker-compose up`. Add `-d` flag if you want to daemonize it. It should create three
  containers. You can inspect them, check logs etc with `docker-compose` commands.
* Check out http://localhost:3456
* If you want to generate fixture data to look at stuff, run `docker-compose exec ayanami rake db:seed`
* Database is also accessable on localhost:13306 with specified user/password
* You can enter any container with `docker compose exec {ayanami|mysql|redis} bash`. Remember that all your changes
will not be permanent, with an exception for MySQL data :)

If you want to switch your hlstatsx stuff to dockerized database completely, you should:

* Make an sql dump with `mysqldump`. Let's call it `dump.sql`
* Ensure that dockerized schema is empty and exists: `docker-compose exec ayanami rake db:drop db:create`
(you should run this command from a source tree)
* run `docker-compose exec mysql mysql -p ayanami < dump.sql ` or
`mysql -h 127.0.0.1 -P 13306 -u MYSQL_USER -p ayanami < dump.sql` to restore dump
* Reconfigure you hlstatsx daemon to use new database URL

By the way, funny fact: hlstatsx web UI does not support mysql5.7 with it's default settings. I've added
`$db->query("SET SESSION sql_mode = ''")` to php runtime to fix this.