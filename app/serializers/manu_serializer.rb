class ManuSerializer < ActiveModel::Serializer
  attributes :name, :verified, :description, :location, :ul, :ul_c
  #has_many :materials, include: :name
end