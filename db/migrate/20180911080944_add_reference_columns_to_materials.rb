class AddReferenceColumnsToMaterials < ActiveRecord::Migration[5.0]
  def change
    add_reference :materials, :group, type: :uuid, foreign_key: true
    add_reference :materials, :function, type: :uuid, foreign_key: true
  end
end
