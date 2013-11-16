module StagingAuthentication
  extend ActiveSupport::Concern

  included do
    http_basic_authenticate_with name: "grace", password: "hrabi"
  end

end
