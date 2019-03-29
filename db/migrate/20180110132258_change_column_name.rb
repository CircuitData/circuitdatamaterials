class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :material_attribute_values, :attribute_id, :material_attribute_id
  end
end
