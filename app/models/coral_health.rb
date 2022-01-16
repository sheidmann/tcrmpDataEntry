class CoralHealth < ApplicationRecord
  validates_presence_of :site, :manager, :user, :date_completed, :rep

  belongs_to :user

  belongs_to :site
  accepts_nested_attributes_for :site

  belongs_to :manager
  accepts_nested_attributes_for :manager

  has_many :transect_corals, :dependent => :destroy, inverse_of: :coral_health
  accepts_nested_attributes_for :transect_corals, :reject_if => :all_blank, :allow_destroy => true

  has_many :coral_codes, through: :transect_corals
  accepts_nested_attributes_for :coral_codes
end
