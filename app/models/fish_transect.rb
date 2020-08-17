class FishTransect < ApplicationRecord
	validates_presence_of :site, :manager, :user, :date_completed, :begin_time, :rep

	belongs_to :user

	belongs_to :site
	accepts_nested_attributes_for :site

	belongs_to :manager
	accepts_nested_attributes_for :manager
end
