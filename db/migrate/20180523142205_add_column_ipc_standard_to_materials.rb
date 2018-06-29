class AddColumnIpcStandardToMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :materials, :ipc_standard, :string
  end
end
