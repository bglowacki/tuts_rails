require 'capistrano/rails'


# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'tuts'
set :repo_url, 'git@github.com:Vangerdahast/tuts_rails.git'
set :rvm_ruby_version, '2.0.0-p247'


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deploy/apps/backend'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
set :default_env, { rvm_bin_path: '/usr/local/rvm/bin/rvm' }

set :log_level, :debug
set :tmp_dir, "/tmp"
set :rvm_type, :system
set :git_enable_submodules, 1


# Default value for :pty is false
# set :pty, true

# Default value for linked_dirs is []

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


namespace :deploy do


  after :published, :restart

  task :restart do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
        execute :bundle, ' exec puma -e production -b unix:///var/run/tuts.sock'
      # end
    end
  end

  # task :bundle_install do
  #   on roles(:app) do
  #     within release_path do
  #       execute :bundle, "--gemfile #{release_path}/Gemfile --binstubs #{shared_path}/bin --without test, development"
  #     end
  #   end
  # end

end
