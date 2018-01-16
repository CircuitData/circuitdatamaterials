class ChangeMaterials < ActiveRecord::Migration[5.0]
  def change
  	remove_column :materials, :ipc_sm_840_class, :string
  	remove_column :materials, :ipc_slash_sheet, :string
  	remove_column :materials, :tg_minimum, :integer
  	remove_column :materials, :td_minimum, :integer
  	remove_column :materials, :flexibel, :boolean
  	remove_column :materials, :additional, :string
  	add_column :materials, :flexible, :boolean
  	add_column :materials, :additonal, :string, array: true, default: []
  	add_column :materials, :ul_94, :string
  	add_column :materials, :accept_equivalent, :boolean
  	add_reference :materials, :information, type: :uuid, foreign_key: true
  end
end
