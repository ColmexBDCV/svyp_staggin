class CreateSesions < ActiveRecord::Migration[5.2]
  def change
    create_table :sesions do |t|
      t.text :titulo
      t.text :descripcion
      t.text :liga_vid
      t.text :pubs
      t.date :fecha_i
      t.date :fecha_f

      t.timestamps
    end
  end
end
