class CoralCode < ApplicationRecord
  validates_presence_of :code_name
  validates_presence_of :group
  validates_presence_of :category
  validates_presence_of :full_name

  has_many :transect_corals

  def combo_name
    "#{code_name} __ #{full_name}"
  end
end
