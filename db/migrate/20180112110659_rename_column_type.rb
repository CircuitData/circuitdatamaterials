class RenameColumnType < ActiveRecord::Migration[5.0]
  def change
    rename_column :material_attribute_values, :type, :material_type
  end
end
