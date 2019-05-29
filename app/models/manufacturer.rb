class Manufacturer < ApplicationRecord
  has_many :materials

  validates :name, presence: true

  def self.names
    pluck(:name, :id).to_a
  end
end
