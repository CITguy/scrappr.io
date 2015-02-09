require 'yaml'

namespace :git do
  desc "Create a new version tag and push"
  task :tag do
    unless `git rev-parse HEAD` == `git rev-parse upstream/master`
      puts %Q{
        *********************************************
        * WARNING: HEAD is not the same as upstream *
        *********************************************
      }
      exit
    end

    # Prompt for the new tag name
    print "Release Version: "
    # read in the new tag name and tag it
    version = STDIN.readline.strip
    if version.empty?
      puts "NO VERSION GIVEN"
      exit
    end

    # create and push tag upstream
    sh "git tag -a #{version} -m #{version}"
    sh "git push --tags upstream"


    # write version to app_config.local.yml for upload on next deploy
    config_path = "#{Rails.root}/config/app_config.local.yml"
    begin
      cfg = YAML::load_file(config_path)
    rescue
      cfg = {}
    end
    cfg['version'] = version
    File.open(config_path, 'w') do |f|
      f.write cfg.to_yaml
    end
  end
end
