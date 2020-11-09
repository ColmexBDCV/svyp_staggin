# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"

set :application, "svp"
set :repo_url, "git+ssh://git@github.com/colmexdev/svp.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/webuser/svp"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/master.key')

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      #unless ENV["IMG_KEEP"]
      #  current_release = capture(:readlink, current_path).to_s
      #  last_release = capture(:ls, "-xt", releases_path).split[1]
      #  last_release_path = releases_path.join(last_release)
      #  execute :cp, "-a", "#{last_release_path}/storage", "/home/webuser/media_backup/cei"
      #  execute :cp, "-a", "#{last_release_path}/storage", current_release
      #end
    end
  end

  after :publishing, :restart
  after :finishing, :cleanup

end
