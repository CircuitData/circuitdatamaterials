class CreateManufaturers < ActiveRecord::Migration[5.0]
  def change
  	enable_extension "uuid-ossp";
    create_table :manufacturers, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :location

      t.timestamps
    end
  end
end
