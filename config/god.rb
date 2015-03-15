# inspiered by https://github.com/blog/519-unicorn-god
rbenv_root = "/usr/local/rbenv"

%w{staging production}.each do |rails_env|
  God.watch do |w|
    rails_root = "/srv/http/#{rails_env}.scrappr.io/current"
    unicorn_pid = "#{rails_root}/tmp/pids/unicorn.pid"
    unicorn_cfg = "#{rails_root}/config/unicorn/#{rails_env}.rb"

    w.name = "unicorn_scrappr_#{rails_env}"
    w.interval = 30.seconds # default

    # bundle exec needs to be run from the rails root
    w.start = "cd #{rails_root} && #{rbenv_root}/shims/bundle exec unicorn -D -E deployment -c #{unicorn_cfg}"

    # QUIT gracefully shuts down workers
    w.stop = "kill -QUIT `cat #{unicorn_pid}`"

    # USR2 causes the master to re-create itself and spawn a new worker pool
    w.restart = "kill -USR2 `cat #{unicorn_pid}`"

    w.start_grace = 10.seconds
    w.restart_grace = 10.seconds
    w.pid_file = unicorn_pid
    w.uid = 'rails'
    w.gid = 'rails'

    w.behavior(:clean_pid_file)

    w.start_if do |start|
      start.condition(:process_running) do |c|
        c.interval = 5.seconds
        c.running = false
      end
    end#start_if

    w.restart_if do |restart|
      restart.condition(:memory_usage) do |c|
        c.above = 300.megabytes
        c.times = [3,5] # 3 out of 5 intervals
      end

      restart.condition(:cpu_usage) do |c|
        c.above = 50.percent
        c.times = 5
      end
    end#restart_if

    w.lifecycle do |on|
      on.condition(:flapping) do |c|
        c.to_state = [:start, :restart]
        c.times = 5
        c.within = 5.minute
        c.transition = :unmonitored
        c.retry_in = 10.minutes
        c.retry_times = 5
        c.retry_within = 2.hours
      end
    end#lifecycle
  end
end#rails_env
