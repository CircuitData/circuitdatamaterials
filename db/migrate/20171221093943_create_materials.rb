class CreateMaterials < ActiveRecord::Migration[5.0]
  def change
    #rename_table :manufaturer, :manufacturer
    create_table :materials, id: :uuid do |t|
      t.string :style
      t.string :group
      t.references :manufacturer, type: :uuid, foreign_key: true
      t.string :name
      t.boolean :flexibel
      t.string :ipc_sm_840_class
      t.string :ipc_slash_sheet
      t.integer :tg_minimum
      t.integer :td_minimum
      t.string :additional
      t.string :link
      t.text :remark

      t.timestamps
    end
  end
end
