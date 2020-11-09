class CreateDocsConsulta < ActiveRecord::Migration[5.2]
  def change
    create_table :docs_consulta do |t|
      t.text :titulo
      t.text :indice
      t.attachment :documento

      t.timestamps
    end
  end
end
