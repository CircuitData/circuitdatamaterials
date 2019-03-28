class ChangeColumnType < ActiveRecord::Migration[5.2]
  def up
    remove_column :materials, :additional
    add_column :materials, :additional, :text
    Material.where.not(ipc_standard: nil).each do |m|
      m.update_column(:ipc_standard, m.ipc_standard.gsub(/\D/, ""))
    end
    change_column :materials, :ipc_standard, :integer, using: "ipc_standard::integer"
  end

  def down
    remove_column :materials, :additional
    add_column :materials, :additional, :jsonb, array: true, default: []
    change_column :materials, :ipc_standard, :string
  end
end
