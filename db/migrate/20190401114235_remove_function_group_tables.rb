class RemoveFunctionGroupTables < ActiveRecord::Migration[5.2]
  def up
    drop_table :functions
    drop_table :groups
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
