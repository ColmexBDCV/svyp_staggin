class Admin < ApplicationRecord
  devise :ldap_authenticatable#, :rememberable

  #def remember_me!
  #  true
  #end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  alias will_save_change_to_email? email_changed?
  attr_accessor :password

  validates_presence_of :usuario
end
