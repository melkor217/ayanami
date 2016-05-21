namespace :db do
  desc "Checks to see if the database exists"
  task :check do
    begin
      Rake::Task['environment'].invoke
      ActiveRecord::Base.connection
    rescue
      # Error if no database exists
      exit 1
    else
      # Error if database is empty
      exit ActiveRecord::Base.connection.tables.count > 0 ? 0 : 1
    end
  end
end