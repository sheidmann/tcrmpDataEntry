class SitesController < ApplicationController
	before_action :require_manager

	def index
		@all_sites = Site.order(site_name: :asc).all

    respond_to do |format|
      format.html # index.html.erb
      #format.xlsx
    end
	end
end