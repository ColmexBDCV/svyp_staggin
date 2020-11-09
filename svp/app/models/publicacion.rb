class Publicacion < ApplicationRecord
  before_save :update_indice, if: :indice_changed?
  before_save :delete_portada, if: -> {portada_del == '1'}
  before_save :delete_documento, if: -> {documento_del == '1'}

  attr_accessor :portada_del
  attr_accessor :documento_del

  validates_presence_of :titulo
  validates_presence_of :indice
  has_attached_file :portada, styles: {thumbnail: "850x1167#", thumb_cut: "850x1167\!"},
      url: '/assets/portadas_pubs/:style/:id/:basename.:extension',
      path: ':rails_root/public/assets/portadas_pubs/:style/:id/:basename.:extension',
      default_url: '/portada.png',
      convert_options: {all: "-background white -flatten +matte"}
  validates_attachment_content_type :portada, content_type: ["image/jpg", "image/jpeg", "image/png"]

  has_attached_file :documento, styles: {thumbnail: ["850x1167#", :jpg], thumb_cut: ["850x1167\!", :jpg]},
      url: '/assets/docs_pubs/:style/:id/:basename.:extension',
      path: ':rails_root/public/assets/docs_pubs/:style/:id/:basename.:extension',
      default_url: '/portada.png',
      convert_options: {all: "-background white -flatten +matte -encoding AdobeStandard -gravity Center"}
  validates_attachment_content_type :portada, content_type: ["image/jpg", "image/jpeg", "image/png", "application/pdf"]

  protected

  def update_indice
    q = Publicacion.where(indice: self.indice).first
    if !q.nil?
      q.update(indice: q.indice + 1)
    end
  end

  def delete_portada
    self.portada = nil
  end

  def delete_documento
    self.documento = nil
  end
end
