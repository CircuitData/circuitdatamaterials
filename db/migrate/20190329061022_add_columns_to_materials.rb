class AddColumnsToMaterials < ActiveRecord::Migration[5.2]
  def change
    change_table(:materials) do |t|
      t.boolean :woven_reinforcement
      t.decimal :cti
      t.decimal :df
      t.decimal :dielectric_breakdown
      t.decimal :dk
      t.decimal :electric_strength
      t.decimal :frequency
      t.decimal :mot
      t.decimal :resin_content
      t.decimal :t260
      t.decimal :t280
      t.decimal :t300
      t.decimal :td_min
      t.decimal :tg_min
      t.decimal :thermal_conductivity
      t.decimal :thickness
      t.decimal :volume_resistivity
      t.decimal :water_absorption
      t.decimal :z_cte
      t.decimal :z_cte_after_tg
      t.decimal :z_cte_before_tg
      t.integer :ipc_slash_sheet, array: true
      t.string :filler, array: true
      t.string :finish
      t.string :flame_retardant
      t.string :foil_roughness
      t.string :ipc_sm_840_class
      t.string :reinforcement
      t.string :resin
    end
    MigrateDataToMaterials.run(Material.all)
  end
end
