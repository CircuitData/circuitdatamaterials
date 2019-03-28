class RenameColumnMaterialType < ActiveRecord::Migration[5.0]
  def change
    rename_column :material_attribute_values, :material_type, :value_type
  end
end
