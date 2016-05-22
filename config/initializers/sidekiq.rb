require 'sidekiq/scheduler'



Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/12/sidekiq' }
  config.on(:startup) do
    Sidekiq.schedule = YAML.load_file(File.expand_path("../../../config/scheduler.yml",__FILE__))
    Sidekiq::Scheduler.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/12/sidekiq' }
end

# uniqueness for activejobs
# https://github.com/mhenrixon/sidekiq-unique-jobs#usage-with-activejob
Sidekiq.default_worker_options = {
    'unique' => :until_and_while_executing,
    'unique_args' => proc do |args|
      [args.first.except('job_id')]
    end
}