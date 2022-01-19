class DashboardController < ApplicationController
	before_action :require_manager

	# View all entered data
	def show
		@diademas = Diadema.all

		@data_by_divers = {}
		@divers = User.where(active: "true")

		@divers.each do |diver|
			if !@data_by_divers.has_key?(diver)
				@data_by_divers[diver] = {
					"boat" => 0,
          "boatfish" => 0,
					"ftrans" => 0,
					"frove" => 0,
					"chealth" => 0,
					"aheight" => 0
				}
			end
			@data_by_divers[diver]["boat"] += diver.boatlog_surveys.count
      @data_by_divers[diver]["boatfish"] += diver.boatlog_surveys.where(survey_type_id: SurveyType.where(category: "fish").ids).count
			@data_by_divers[diver]["ftrans"] += diver.fish_transects.count
			@data_by_divers[diver]["frove"] += diver.fish_rovers.count
			@data_by_divers[diver]["chealth"] += diver.coral_healths.count
			@data_by_divers[diver]["aheight"] += diver.algae_heights.count
		end
	  @data_by_divers = @data_by_divers.sort_by { |diver, data| diver.name }

		respond_to do |format|
			format.html # show.html.erb
		end
	end
end
