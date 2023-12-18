class Shop < ApplicationRecord
  # has_many :products
  # belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  validates :tel, presence: true , length: { maximum: 50 }, 
                  format: { with: /\A[\d\+\-\(\)]+\z/, message: "格式不正確" }

  
  

end
