class CreatePublicacions < ActiveRecord::Migration[5.2]
  def change
    create_table :publicacions do |t|
      t.text :titulo
      t.attachment :portada
      t.text :autor
      t.text :edicion
      t.text :descripcion
      t.text :liga_vid
      t.integer :indice

      t.timestamps
    end
  end
end
