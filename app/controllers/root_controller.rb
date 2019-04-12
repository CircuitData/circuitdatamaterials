class RootController < ApplicationController
  def index
    @generic_material_count = Material.generic.count
    @manufacturer_material_count = Material.with_manufacturer.count
    @manufacturer_count = Manufacturer.count
  end
end
