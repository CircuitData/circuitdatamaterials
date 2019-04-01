class RemoveUnneededTables < ActiveRecord::Migration[5.2]
  def up
    drop_table :material_attribute_values
    drop_table :material_attributes
    remove_column :materials, :group_id
    remove_column :materials, :function_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
