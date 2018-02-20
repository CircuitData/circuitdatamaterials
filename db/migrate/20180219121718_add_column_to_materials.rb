class AddColumnToMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :materials, :source, :string
  end

  def up
    change_column :materials, :verified, :boolean, default: false
    change_column :materials, :flexible, :boolean, default: false
    change_column :manufacturers, :verified, :boolean, default: false
  end

  def down
    change_column :materials, :verified, :boolean, default: nil
    change_column :materials, :verified, :boolean, default: false
    change_column :manufacturers, :verified, :boolean, default: false
  end
end
