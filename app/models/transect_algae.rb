class TransectAlgae < ApplicationRecord
  validates_presence_of :algae_height, :algae

  belongs_to :algae_height

  belongs_to :algae
  accepts_nested_attributes_for :algae
end
