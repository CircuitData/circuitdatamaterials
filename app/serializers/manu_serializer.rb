class ManuSerializer < ActiveModel::Serializer
  attributes :name, :verified, :description, :location
  #has_many :materials, include: :name
end