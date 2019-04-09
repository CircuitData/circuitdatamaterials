class EnsureManufacturerNamesAreUnique < ActiveRecord::Migration[5.2]
  def up
    enable_extension :citext
    change_column :manufacturers, :name, :citext
    add_index :manufacturers, :name, unique: true
  end

  def down
    remove_index :manufacturers, :name
    change_column :manufacturers, :name, :string
    disable_extension :citext
  end
end
