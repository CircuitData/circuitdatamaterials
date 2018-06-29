class RenameColumnCircuitDataVersionToVersion < ActiveRecord::Migration[5.0]
  def change
  	rename_column :materials, :circuitdata_version, :version
  end
end
