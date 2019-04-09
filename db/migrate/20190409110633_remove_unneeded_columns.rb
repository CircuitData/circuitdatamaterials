class RemoveUnneededColumns < ActiveRecord::Migration[5.2]
  def up
    remove_column :materials, :filler
    remove_column :materials, :flame_retardant
    remove_column :materials, :frequency
    remove_column :materials, :additional
    remove_column :materials, :reinforcement
    remove_column :materials, :remark
    remove_column :materials, :resin
    remove_column :materials, :resin_content
    remove_column :materials, :thickness
    remove_column :materials, :verified
    remove_column :materials, :volume_resistivity
    remove_column :materials, :accept_equivalent
    remove_column :materials, :woven_reinforcement
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
