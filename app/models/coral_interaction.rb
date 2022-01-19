class CoralInteraction < ApplicationRecord
  validates_presence_of :transect_coral, :coral_code

  belongs_to :transect_coral
  accepts_nested_attributes_for :transect_coral

  belongs_to :coral_code
  accepts_nested_attributes_for :coral_code
end
