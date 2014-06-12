class DownloadRecord < ActiveRecord::Base
  belongs_to :download
  belongs_to :purchase
end
