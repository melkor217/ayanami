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
