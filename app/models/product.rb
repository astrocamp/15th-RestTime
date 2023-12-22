# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { order(id: :desc)}

  validates :title, presence: true
  validates :service_hour, presence: true
  validates :price, numericality: { greater_than: 0 }
end
