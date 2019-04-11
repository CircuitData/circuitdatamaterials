class RootController < ApplicationController
  def index
    @material_count = Material.count
    @manufacturer_count = Manufacturer.count
    @manufacturers = Manufacturer.all.group_by { |m| m.name.downcase.first }
  end
end
