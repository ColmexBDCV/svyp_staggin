class AddFechaToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_column :publicacions, :fecha, :date
  end
end
