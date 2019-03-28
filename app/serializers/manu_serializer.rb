class ManuSerializer < ActiveModel::Serializer
  attributes :name, :verified, :description, :location, :ul, :ul_c
end
