class Sesion < ApplicationRecord
  before_save :delete_banner, if: -> {banner_del == '1'}

  validates_presence_of :titulo
  has_attached_file :banner, styles: {},
      url: '/assets/banners_sesiones/:style/:id/:basename.:extension',
      path: ':rails_root/public/assets/banners_sesiones/:style/:id/:basename.:extension',
      default_url: '/vacio.png'

  validates_attachment_content_type :banner, content_type: ["image/jpg", "image/jpeg", "image/png"]

  protected

  def delte_banner
    self.banner = nil
  end

end
