class Persona < ApplicationRecord
  before_save :delete_foto, if: -> {foto_del == '1'}

  attr_accessor :foto_del

  validates_presence_of :nombre
  validates_presence_of :indice
  has_attached_file :foto, styles: {},
      url: '/assets/fotos_personas/:style/:id/:basename.:extension',
      path: ':rails_root/public/assets/fotos_personas/:style/:id/:basename.:extension'

  validates_attachment_content_type :foto, content_type: ['image/jpg', 'image/jpeg', 'image/png']

  protected

  def delete_foto
    self.foto = nil
  end
end
