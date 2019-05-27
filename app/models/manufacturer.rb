class Manufacturer < ApplicationRecord
  has_many :materials

  validates :name, presence: true

  def self.names
    all.map{|material| [material.name, material.id]}
  end
end
