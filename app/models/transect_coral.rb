class TransectCoral < ApplicationRecord
  validates_presence_of :coral_health, :coral_code

  belongs_to :coral_health
  
  belongs_to :coral_code
  accepts_nested_attributes_for :coral_code

  has_many :coral_interactions, :dependent => :destroy, inverse_of: :transect_coral
  accepts_nested_attributes_for :coral_interactions

  def count_interactions
    self.coral_interactions.count
  end
end
