class AddImagenToSesion < ActiveRecord::Migration[5.2]
  def change
    add_attachment :sesions, :banner
  end
end
