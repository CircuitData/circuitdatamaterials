class Manufacturer < ApplicationRecord
  has_many :materials

  validates :name, presence: true
end
