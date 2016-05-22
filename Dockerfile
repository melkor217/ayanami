FROM debian:sid

RUN apt-get update && apt-get install -y cron git ruby bundler zlib1g-dev libmysqlclient-dev libsqlite3-dev mysql-client wget curl
RUN rm -rfv /var/lib/apt/lists/*

RUN mkdir /ayanami
WORKDIR /ayanami

COPY ./Gemfile .
COPY ./Gemfile.lock .

ENV RAILS_ENV production
ENV RAILS_PUBLIC_FILE_SERVER true

RUN bundle install
COPY . /ayanami

RUN ./bin/rake assets:precompile
RUN whenever -w # add crontab for delayed stuff

CMD unicorn -c config/unicorn.rb

