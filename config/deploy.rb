# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

# set :application, "todo_api"
# set :repo_url, "git@github.com:S0UPernova/todo_api.git"
# Also works with non-github repos, I roll my own gitolite server
# set :deploy_to, "/home/ubuntu/#{fetch :application}"
# set :rbenv_prefix, '/usr/bin/rbenv exec' # Cf issue: https://github.com/capistrano/rbenv/issues/96
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'






# require 'rbenv/capistrano'
# require 'bundler/capistrano'

set :rbenv_type, :user

set :application, "todo_api"
set :domain, 'http://ec2-52-9-219-7.us-west-1.compute.amazonaws.com/'

set :rbenv_prefix, '/usr/bin/rbenv exec' # Cf issue: https://github.com/capistrano/rbenv/issues/96
# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
# Roles
# role :web, domain
# role :app, domain
# role :db,  domain, :primary => true

#deployment details
set :deploy_via, :copy
set :user, "ubuntu"
set :copy_compression, :bz2
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false
set :deploy_to, "/home/ubuntu/#{fetch :application}"

# set :asset_roles, []

# default_run_options[:pty] = true
set :ssh_options, {:forward_agent => true}
set :ssh_options, {:auth_methods => "publickey"}
set :ssh_options, {:keys => ["~/.ssh/todo_api.pem"]}

#repo details
# set :scm, :git
set :repository,  "git@github.com:S0UPernova/todo_api.git"
set :repo_url, "https://github.com/S0UPernova/todo_api.git"

# set :scm_username, 'S0UPernova'
set :keep_releases, 2
# set :branch, "master"





# append :linked_files, 'config/database.yml', 'config/master.key'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
