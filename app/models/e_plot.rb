class EPlot < ApplicationRecord
	validates_presence_of :e_survey, :plot

	belongs_to :e_survey

	has_many :e_plot_corals, :dependent => :destroy, inverse_of: :e_plot
  accepts_nested_attributes_for :e_plot_corals
end
