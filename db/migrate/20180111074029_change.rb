class Change < ActiveRecord::Migration[5.0]
  def change
  	add_reference :material_attributes, :material, type: :uuid, foreign_key: true
  	remove_column :materials, :material_attribute_id, :uuid 
  end
end
