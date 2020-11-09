class CreateVids < ActiveRecord::Migration[5.2]
  def change
    create_table :vids do |t|
      t.text :liga
      t.integer :indice

      t.timestamps
    end
  end
end
