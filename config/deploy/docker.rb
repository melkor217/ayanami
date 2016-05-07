# Config for capistrano

server 'localhost', roles: %w{web app}
set :deploy_to, '/var/tmp/ayanami'
set :application, 'ayanami'
set :repo_url, 'https://github.com/melkor217/ayanami.git'

set :docker_compose, true
set :docker_compose_build_services, 'ayanami'
set :docker_compose_remove_after_stop, false
set :docker_compose_project_name, 'test'


set :docker_detach, false
set :docker_compose, true
set :docker_compose_build_services, 'ayanami-docker'
set :docker_compose_remove_after_stop, false
set :docker_compose_project_name, 'ayanami'


set :docker_detach, false

