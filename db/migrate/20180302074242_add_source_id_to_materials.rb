class AddSourceIdToMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :materials, :source_id, :string
    add_column :manufacturers, :source, :string
    add_column :manufacturers, :source_id, :string
  end
end
