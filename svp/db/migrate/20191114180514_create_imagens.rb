class CreateImagens < ActiveRecord::Migration[5.2]
  def change
    create_table :imagens do |t|
      t.attachment :imagen
      t.text :sesion
      t.integer :indice
      t.text :caption

      t.timestamps
    end
  end
end
