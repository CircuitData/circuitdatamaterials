class CreateInformation < ActiveRecord::Migration[5.0]
  def change
    create_table :information, id: :uuid do |t|
      t.string :type
      t.string :name

      t.timestamps
    end
  end
end
