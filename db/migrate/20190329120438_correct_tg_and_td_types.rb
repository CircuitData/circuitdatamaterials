class CorrectTgAndTdTypes < ActiveRecord::Migration[5.2]
  def up
    change_column :materials, :tg_min, :integer
    change_column :materials, :td_min, :integer
  end

  def down
    change_column :materials, :tg_min, :integer
    change_column :materials, :td_min, :integer
  end
end
