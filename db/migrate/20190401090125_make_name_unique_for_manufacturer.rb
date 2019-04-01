class MakeNameUniqueForManufacturer < ActiveRecord::Migration[5.2]
  def change
    add_index :materials, [:manufacturer_id, :name], unique: true
  end
end
