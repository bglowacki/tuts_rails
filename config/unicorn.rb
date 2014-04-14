environment = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'production'
root = "/home/deploy/apps/backend/staging/current"
pid "#{root}/tmp/pids/unicorn.pid"
working_directory root
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.dev.sock"
worker_processes 2
timeout 30

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end