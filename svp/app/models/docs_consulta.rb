class DocsConsulta < ApplicationRecord
  before_save :delete_documento, if: -> {documento_del == '1'}
  before_save :update_indice, if: :indice_changed?
  after_destroy :shift_indice

  attr_accessor :documento_del

  validates_presence_of :titulo
  validates_presence_of :indice
  has_attached_file :documento, styles: {},
      url: '/assets/archivos_consulta/:style/:id/:basename.:extension',
      path: ':rails_root/public/assets/archivos_consulta/:style/:id/:basename.:extension'

  validates_attachment_content_type :documento, content_type: ["application/pdf"]
  validates_attachment_presence :documento

  protected

  def delete_documento
    self.documento = nil
  end

  def update_indice
    q = DocsConsulta.where(indice: self.indice).first
    if !q.nil?
      q.update(indice: q.indice + 1)
    end
  end

  def shift_indice
    DocsConsulta.where("indice >= :ind", ind: self.indice).order(indice: :asc).each do |d|
      d.update(indice: d.indice - 1)
    end
  end
end
