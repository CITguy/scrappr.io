require 'yaml'

def load_config(file)
  YAML::load(File.open(Rails.root.join(file)))
rescue
  {}
end

APP_CONFIG = {}

# Main Config File
# DO NOT PUT SENSITIVE INFORMATION IN THIS FILE!
APP_CONFIG.merge!(load_config("config/app_config.yml"))

# Private Config File
# This is where sensitive information should be placed.
APP_CONFIG.merge!(load_config("config/private.yml"))

## Environment-Specific Configuration
# THIS SHOULD NOT BE PUT UNDER VERSION CONTROL!
# It is meant to hold sensitive data, if need be.
# File is essentially "empty" by default on remote servers.
# Add values as needed on a per server basis.
APP_CONFIG.merge!(load_config("config/app_config.local.yml"))
