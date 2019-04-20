class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  has_many :reviews
  belongs_to :category

  validates_associated :reviews

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def sold_out?(product)
    product.quantity == 0
  end

end
