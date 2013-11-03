if File.exists?("#{Rails.root}/config/facebook.yml") && !Rails.env.test?
  Rails.configuration.facebook_config = YAML.load_file("#{Rails.root}/config/facebook.yml")
  Rails.logger.info "[Facebook] Config file loaded"
else
  Rails.logger.warn "[Facebook] Could not find /config/facebook.yml"
end
