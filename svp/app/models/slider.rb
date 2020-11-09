class Slider < ApplicationRecord
  before_save :delete_banner, if: -> {banner_del == '1'}
  before_save :update_indice, if: :indice_changed?

  attr_accessor :banner_del

  has_attached_file :banner, styles: {},
      url: '/assets/sliders/:style/:id/:basename.:extension',
      path: ':rails_root/public/assets/sliders/:style/:id/:basename.:extension'

  validates_attachment_content_type :banner, content_type: ["image/jpg", "image/jpeg", "image/png"]

  protected

  def delete_banner
    self.banner = nil
  end

  def update_indice
    q = Slider.where(indice: self.indice).first
    if !q.nil?
      q.update(indice: q.indice + 1)
    end
  end
end
