class SitesController < ApplicationController
	before_action :require_manager

	# View field progress by site
	def index
		@all_sites = Site.order(site_name: :asc).all

    respond_to do |format|
      format.html # index.html.erb
      #format.xlsx
    end
	end

	# View all surveys completed at each site
	def show
    @site = Site.find(params[:id])
    @site_surveys = @site.boatlog_surveys.order(survey_type_id: :asc, rep: :asc).all
    @fish_surveys = @site_surveys.where(survey_type_id: SurveyType.find_by(category: "fish").id).all
    @coral_surveys = @site_surveys.where(survey_type_id: SurveyType.find_by(category: "benthic").id).all

    respond_to do |format|
      format.html # show.html.erb
    end
	end
end