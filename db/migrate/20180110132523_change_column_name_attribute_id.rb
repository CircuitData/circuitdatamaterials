class ChangeColumnNameAttributeId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :materials, :attribute_id, :material_attribute_id
  end
end
