FROM debian:latest
RUN apt-get update && apt-get install -y git ruby bundler zlib1g-dev libmysqlclient-dev libsqlite3-dev mysql-client
ENV RAILS_ENV docker
COPY . /ayanami
WORKDIR /ayanami
RUN bundle install
CMD ./bin/rails server
