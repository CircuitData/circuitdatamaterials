class AddVerifiedColumnToMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :materials, :verified, :boolean, default: false, null: false
  end
end
