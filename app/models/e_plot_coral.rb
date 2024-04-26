class EPlotCoral < ApplicationRecord
	validates_presence_of :e_plot, :coral_code

  belongs_to :e_plot
  accepts_nested_attributes_for :e_plot
  
  belongs_to :coral_code
  accepts_nested_attributes_for :coral_code
end
