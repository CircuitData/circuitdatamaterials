class AddColumnsToManufacturers < ActiveRecord::Migration[5.0]
  def change
    add_column :manufacturers, :ul, :string
    add_column :manufacturers, :ul_c, :string
  end
end
