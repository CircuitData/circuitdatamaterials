class AddColumnCircuitDataVersionToMaterials < ActiveRecord::Migration[5.0]
  def change
  	add_column :materials, :circuitdata_version, :string
  end
end
