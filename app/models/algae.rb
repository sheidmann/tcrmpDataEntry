class Algae < ApplicationRecord
  validates_presence_of :code_name
  validates_presence_of :full_name

  def combo_name
    "#{code_name} __ #{full_name}"
  end
end
