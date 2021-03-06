# config valid only for Capistrano 3.1
lock '3.2.1'

set :apps_dir, "/srv/http"
set :user, PRIVATE["deploy"]["user"]
set :port, PRIVATE["deploy"]["port"]

set :application, 'scrappr.io'
set :repo_url, 'https://github.com/CITguy/scrappr.io.git'
set :branch, :master
set :deploy_via, :remote_cache
set :deploy_to, "#{fetch(:apps_dir)}/#{fetch(:stage)}.#{fetch(:application)}"
set :scm, :git
set :format, :pretty
set :linked_files, %w[
  config/database.yml
  config/app_config.local.yml
  config/private.yml
]
set :keep_releases, 3
set :pty, true
set :linked_dirs, %w[
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  vendor/bundle
  public/system
]

# because reasons (https://github.com/capistrano/bundler/issues/45)
set :bundle_binstubs, nil

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


## RBENV CONFIGS
# (https://github.com/capistrano/rbenv)
set :rbenv_type, :system
set :rbenv_ruby, File.read(".ruby-version").strip
set :rbenv_map_bins, %w[ rake gem bundle ruby rails ]
set :rbenv_roles, :all


## UNICORN CONFIGS
# (https://github.com/tablexi/capistrano3-unicorn)
set :unicorn_pid, File.join(current_path, "tmp", "pids", "unicorn.pid")
# set :unicorn_config_path, File.join(current_path, "config", "unicorn", "#{fetch(:rails_env)}.rb")
# set :unicorn_restart_sleep_time, 3
# set :unicorn_roles, :app
# set :unicorn_options, ""
# set :unicorn_rack_env, (fetch(:rails_env) == "development" ? "development" : "deployment")
set :unicorn_bundle_gemfile, File.join(current_path, "Gemfile")


## RAILS CONFIGS
#set :rails_env, 'staging'                  # If the environment differs from the stage name
#set :migration_role, 'migrator'            # Defaults to 'db'
#set :conditionally_migrate, true           # Defaults to false
set :assets_roles, [:app]                   # Defaults to [:web]
#set :assets_prefix, 'prepackaged-assets'   # Defaults to 'assets' this should match config.assets.prefix in your rails config/application.rb



namespace :bundler do
  desc "Cleanup old bundled gems - Use with CAUTION! This may break a rollback!"
  task :cleanup do
    on roles(:app) do
      within(current_path) { execute :bundle, :clean }
    end
  end#:cleanup
end#:bundler

namespace :rails do
  desc "Remote Console"
  task :console do
    user = fetch(:user)
    port = fetch(:port)
    cmd = "bundle exec rails console #{fetch(:rails_env)}"
    on roles(:console) do
      exec "ssh -l #{user} #{host} -p #{port} -t 'cd #{fetch(:deploy_to)}/current && #{cmd}'"
    end
  end#:console
end#:rails

task :ping do
  on roles(:app) do
    execute :echo, "PONG `whoami`@`hostname`"
  end
end

namespace :deploy do
  desc "ensure {shared}/config/app_config.local.yml exists"
  task :ensure_local_app_config do
    shared_config = "#{fetch(:deploy_to)}/shared/config"
    on roles(:app) do
      upload! "config/app_config.local.yml", File.join(deploy_to, "shared", "config", "app_config.local.yml")
      #if test("[ ! -e #{shared_config}/app_config.local.yml ]")
      #  execute "echo '_:' >> #{shared_config}/app_config.local.yml"
      #end
    end
  end#:ensure_local_app_config


  desc "upload private.yml required for application to function"
  task :upload_private do
    on roles(:app) do
      upload! "config/private.yml", File.join(deploy_to, "shared", "config", "private.yml")
    end
  end#:upload_private


  before "deploy:check:linked_files", :ensure_local_app_config
  before "deploy:check:linked_files", :upload_private
  after :publishing, "unicorn:legacy_restart"
end#:deploy
