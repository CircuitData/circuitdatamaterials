class RenameColumnAdditionaltoMaterials < ActiveRecord::Migration[5.0]
  def change
    rename_column :materials, :additonal, :additional
  end
end
