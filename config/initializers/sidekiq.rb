# uniqueness for activejobs
# https://github.com/mhenrixon/sidekiq-unique-jobs#usage-with-activejob
Sidekiq.default_worker_options = {
    'unique' => :until_and_while_executing,
    'unique_args' => proc do |args|
      [args.first.except('job_id')]
    end
}