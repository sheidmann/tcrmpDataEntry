class TransectCoral < ApplicationRecord
  validates_presence_of :coral_health, :coral_code

  belongs_to :coral_health
  
  belongs_to :coral_code
  accepts_nested_attributes_for :coral_code
end
