class AlgaeHeight < ApplicationRecord
  validates_presence_of :site, :manager, :user, :date_completed, :rep

  belongs_to :user

  belongs_to :site
  accepts_nested_attributes_for :site

  belongs_to :manager
  accepts_nested_attributes_for :manager

  has_many :transect_algaes, :dependent => :destroy, inverse_of: :algae_height
  accepts_nested_attributes_for :transect_algaes, :reject_if => :all_blank, :allow_destroy => true

  has_many :algaes, through: :transect_algaes
  accepts_nested_attributes_for :algaes
end
