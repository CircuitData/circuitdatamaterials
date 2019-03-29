class ChangeTableNameAttriubtes < ActiveRecord::Migration[5.0]
  def change
    rename_table :attributes, :material_attributes
    rename_table :attribute_values, :material_attribute_values
  end
end
