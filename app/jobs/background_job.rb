class BackgroundJob

  protected

  def log_info(message)
    Rails.logger.info("#{ self.class } -- #{ message }")
  end
  alias_method :log, :log_info

  def log_error(message)
    Rails.logger.error("#{ self.class } -- #{ message }")
  end

end
