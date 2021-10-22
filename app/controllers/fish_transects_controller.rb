class FishTransectsController < ApplicationController
	before_action :require_user

	# Create a new fish transect
	def new
		@ftran = FishTransect.new
		@ftran.diademas.build
		@ftran.transect_fishes.build

		respond_to do |format|
	  		format.html # new.html.erb
	  		format.json { render json: @ftran }
	  	end
	end

	def create
		@ftran = FishTransect.new( fish_transect_params )

		respond_to do |format|
		  # successful creation
      if @ftran.save
        format.html { redirect_to @ftran, notice: 'Fish transect successfully created.' }
        format.json { render json: @ftran, status: :created, location: @ftran }
      # otherwise, print errors
      else
        format.html { render action: "new" }
        format.json { render json: @ftran.errors, status: :unprocessable_entity }
      end
    end
	end

	# View all of a user's fish transects
	def index
		@new_ftran = FishTransect.new # use in the view to render a form
		# Only show transects
    if @current_user.manager?
      @ftrans = FishTransect.order(date_completed: :asc).all
      @filename = "all"
    else
      @ftrans = @current_user.fish_transects.order(date_completed: :asc).all
      @filename = @current_user.name
    end

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @ftrans.as_csv, filename: "FishTransects_#{@filename}_#{Date.today}.csv" }
    end
	end

	# View a fish transect
  def show
    @ftran = FishTransect.find(params[:id])
    @tranfs = @ftran.transect_fishes.all
    @diademas = @ftran.diademas.all

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @fish_transect }
    end
	end

	# Edit a fish transect
	def edit
		@ftran = FishTransect.find(params[:id])
	end

	# Update the fish transect
	def update
    @ftran = FishTransect.find(params[:id])

    respond_to do |format|
		  # successful update
      if @ftran.update(fish_transect_params)
        format.html { redirect_to @ftran, notice: 'Fish transect successfully updated.' }
        format.json { render json: @ftran, status: :created, location: @ftran }
      # Otherwise, print errors
      else
        format.html { render action: "edit" }
        format.json { render json: @ftran.errors, status: :unprocessable_entity }
      end
    end
   end

	# Delete a fish transect
	def destroy 
	  @ftran = FishTransect.find(params[:id])
	  #@boatlog.destroy
	  # Successful deletion
	  if @ftran.destroy
      redirect_to '/fish_transects', notice: "Fish transect deleted"
	  # Error occurred
	  else
	  	redirect_to '/fish_transects', notice: "Error: fish transect not deleted"
	  end
	end

	private

	def fish_transect_params
		params.require(:fish_transect).permit(:manager_id, :site_id, :user_id, :date_completed, :begin_time, :rep, :completed_m, :notes, :oc_cc, 
      diademas_attributes: [:id, :test_size_cm, :_destroy], 
      transect_fishes_attributes: [:id, :fish_id, :x0to5, :x6to10, :x11to20, :x21to30, :x31to40, :x41to50, :x51to60, :x61to70, :x71to80, :x81to90, :x91to100, :x101to110, :x111to120, :x121to130, :x131to140, :x141to150, :xgt150, :_destroy])
	end
end
