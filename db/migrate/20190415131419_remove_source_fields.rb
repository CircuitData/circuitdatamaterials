class RemoveSourceFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :manufacturers, :source, :string
    remove_column :manufacturers, :source_id, :string
    remove_column :materials, :source, :string
    remove_column :materials, :source_id, :string
    remove_column :materials, :version, :string
  end
end
