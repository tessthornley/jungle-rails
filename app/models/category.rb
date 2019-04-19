class Category < ActiveRecord::Base

  has_many :products

  validates_associated :products
  
  validates :name, presence: true, uniqueness: true

end
