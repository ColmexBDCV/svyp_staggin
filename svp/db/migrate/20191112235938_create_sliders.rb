class CreateSliders < ActiveRecord::Migration[5.2]
  def change
    create_table :sliders do |t|
      t.attachment :banner
      t.text :liga
      t.integer :indice

      t.timestamps
    end
  end
end
