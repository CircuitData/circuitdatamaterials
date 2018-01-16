class AddColumns < ActiveRecord::Migration[5.0]
  def change
  	rename_column :materials, :style, :function
  	add_column :materials, :verified, :boolean
  	add_column :manufacturers, :verified, :boolean
  	add_column :material_attribute_values, :type, :string
  end
end
