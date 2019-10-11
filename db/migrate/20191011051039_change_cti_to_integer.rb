class ChangeCtiToInteger < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up { change_column :materials, :cti, :integer }
      dir.down { change_column :materials, :cti, :decimal }
    end
  end
end
