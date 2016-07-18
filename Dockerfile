FROM debian:sid

CMD ["passenger", "start"]

RUN apt-get update && apt-get install -y git ruby bundler libcurl4-openssl-dev libssl-dev zlib1g-dev libmysqlclient-dev wget curl npm nodejs-legacy procps
RUN rm -rfv /var/lib/apt/lists/*

RUN mkdir /ayanami
WORKDIR /ayanami

COPY ./Gemfile .
COPY ./Gemfile.lock .

ENV RAILS_ENV production
ENV RAILS_PUBLIC_FILE_SERVER true

RUN bundle install
RUN passenger-install-nginx-module --auto

COPY ./package.json .
RUN npm install


COPY . /ayanami

RUN rake assets:precompile

