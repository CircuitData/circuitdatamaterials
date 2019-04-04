class MakeFieldsRequiredInDb < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:manufacturers, :name, false)
    change_column_null(:materials, :name, false)
    change_column_null(:materials, :function, false)
  end
end
