module StagingAuthentication
  extend ActiveSupport::Concern

  included do
    if Rails.env.staging?
      http_basic_authenticate_with name: "grace", password: "hrabi"
    end
  end

end
