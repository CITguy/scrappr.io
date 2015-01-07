# unicorn_rails -c config/unicorn/production.rb -E production -D

# 4 processes and 1 master
worker_processes 4

# Load rails + application code into the master before forking workers
# for super-fast worker spawn times
preload_app true

# Restart any workers that haven't responded in 90 seconds
timeout 90

app_root = "/srv/http/production.scrappr.io/current"

stderr_path "#{app_root}/log/unicorn.stderr.log"
stdout_path "#{app_root}/log/unicorn.stdout.log"

# MUST MATCH upstream socket in NGINX configuration
listen "#{app_root}/tmp/sockets/unicorn.sock", :backlog => 64

# MUST MATCH :unicorn_pid defined in config/deploy
pid "#{app_root}/tmp/pids/unicorn.pid"


before_fork do |server, worker|
  # With 'preload_app true', there's no need for the master process to hold a connection
  defined?(ActiverRecord::Base) && ActiveRecord::Base.connection.disconnect!

  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app).  When this new Unicorn is completely loaded
  # it will bein spawning workers.  The first worker spawned will check to
  # see if an .oldbin pidfile exists.  If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die.  To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end#before_fork


after_fork do |server, worker|
  # REQUIRED for Rails + 'preload_app true'
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
