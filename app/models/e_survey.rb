require 'csv'

class ESurvey < ApplicationRecord
	validates_presence_of :fid, :user, :team, :role, :date_completed

	belongs_to :user

	has_many :e_plots, :dependent => :destroy, inverse_of: :e_survey
	accepts_nested_attributes_for :e_plots, :reject_if => :all_blank, :allow_destroy => true

	has_many :e_plot_corals, through: :e_plots
  accepts_nested_attributes_for :e_plot_corals

  has_many :coral_codes, through: :e_plot_corals
  accepts_nested_attributes_for :coral_codes

  has_many :e_esa_pas, :dependent => :destroy, inverse_of: :e_survey
	accepts_nested_attributes_for :e_esa_pas, :reject_if => :all_blank, :allow_destroy => true
end
