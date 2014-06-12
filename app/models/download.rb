class Download < ActiveRecord::Base
  has_many :purchases

  validates :filename, presence: true
  validates :path, presence: true
  validates :shopify_product_id, presence: true

  def full_path
    File.join(Rails.root, 'downloads', path)
  end
end
