class Imagen < ApplicationRecord
  before_save :delete_imagen, if: -> {imagen_del == '1'}
  before_save :update_indice, if: :indice_changed?
  after_destroy :shift_indice

  attr_accessor :imagen_del

  validates_presence_of :indice
  validates_presence_of :sesion
  has_attached_file :imagen, styles: {thumb: "1000x550>", thumb_cut: "1000x550#", thumb_alt: "1000x550!"},
      url: '/assets/imgs_galeria/:style/:id/:basename.:extension',
      path: ':rails_root/public/assets/imgs_galeria/:style/:id/:basename.:extension'
  validates_attachment_content_type :imagen, content_type: ["image/jpg", "image/jpeg", "image/png"]
  validates_attachment_presence :imagen

  protected

  def delete_imagen
    self.imagen = nil
  end

  def update_indice
    q = Imagen.where(indice: self.indice, sesion: self.sesion).first
    if !q.nil?
      q.update(indice: q.indice + 1)
    end
  end

  def shift_indice
    Imagen.where("indice > :ind and sesion = :ses", ind: self.indice, ses: self.sesion).order(indice: :asc).each do |i|
      i.update(indice: i.indice - 1)
    end
  end
end
