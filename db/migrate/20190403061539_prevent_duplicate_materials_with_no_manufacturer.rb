class PreventDuplicateMaterialsWithNoManufacturer < ActiveRecord::Migration[5.2]
  def change
    add_index :materials, [:name], unique: true, where: "(manufacturer_id IS NULL)"
  end
end
