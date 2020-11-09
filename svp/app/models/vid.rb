class Vid < ApplicationRecord
  before_save :update_indice, if: :indice_changed?
  after_destroy :shift_indice

  protected

  def update_indice
    q = Vid.where(indice: self.indice).first
    if !q.nil?
      q.update(indice: q.indice + 1)
    end
  end

  def shift_indice
    Vid.where("indice > :indice", indice: self.indice).order(indice: :asc).each do |v|
      v.update(indice: v.indice - 1)
    end
  end
end
