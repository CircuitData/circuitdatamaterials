class CreateDiaelectric < ActiveRecord::Migration[5.0]
  def change
    remove_reference :materials, :information
    rename_table :information, :attributes
    add_reference :materials, :attribute, type: :uuid, foreign_key: true
    create_table :attribute_values, id: :uuid do |t|
      t.string :value
      t.references :attribute, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
