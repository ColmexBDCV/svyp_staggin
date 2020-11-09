class AddDocumentoToPublicacion < ActiveRecord::Migration[5.2]
  def change
    add_attachment :publicacions, :documento
  end
end
