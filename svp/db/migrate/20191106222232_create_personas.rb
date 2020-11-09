class CreatePersonas < ActiveRecord::Migration[5.2]
  def change
    create_table :personas do |t|
      t.text :nombre
      t.text :semblanza
      t.attachment :foto
      t.text :twitter
      t.text :fb
      t.integer :indice

      t.timestamps
    end
  end
end
