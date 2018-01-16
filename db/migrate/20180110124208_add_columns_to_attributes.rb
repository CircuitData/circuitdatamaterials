class AddColumnsToAttributes < ActiveRecord::Migration[5.0]
  def change
  	add_column :attributes, :name, :string
  end
end
