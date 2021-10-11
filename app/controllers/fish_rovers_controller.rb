class FishRoversController < ApplicationController
	before_action :require_user

	# Create a new fish rover
	def new
		@frove = FishRover.new
    @frove.rover_fishes.build

		respond_to do |format|
  		format.html # new.html.erb
  		format.json { render json: @frove }
  	end
	end

  def create
    @frove = FishRover.new( fish_rover_params )

    respond_to do |format|
      # successful creation
      if @frove.save
        format.html { redirect_to @frove, notice: 'Fish rover successfully created.' }
        format.json { render json: @frove, status: :created, location: @frove }
      # otherwise, print errors
      else
        format.html { render action: "new" }
        format.json { render json: @frove.errors, status: :unprocessable_entity }
      end
    end
  end

	# View all of a user's fish rovers
	def index
		@new_frove = FishRover.new # use in the view to render a form
		# Only show rovers
    if @current_user.manager?
      @frove = FishRover.order(date_completed: :asc).all
      @filename = "all"
    else
  		@frove = @current_user.fish_rovers.order(date_completed: :asc).all
      @filename = @current_user.name
    end

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @frove.as_csv, filename: "FishRovers_#{@filename}_#{Date.today}.csv" }
    end
	end

  # View a fish rover
  def show
    @frove = FishRover.find(params[:id])
    @rovefs = @frove.rover_fishes.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # Edit a fish rover
  def edit
    @frove = FishRover.find(params[:id])
  end

  # Update the fish transect
  def update
    @frove = FishRover.find(params[:id])

    respond_to do |format|
      # successful update
      if @frove.update(fish_rover_params)
        format.html { redirect_to @frove, notice: 'Fish rover successfully updated.' }
        format.json { render json: @frove, status: :created, location: @frove }
      # Otherwise, print errors
      else
        format.html { render action: "edit" }
        format.json { render json: @frove.errors, status: :unprocessable_entity }
      end
    end
   end

  # Delete a fish transect
  def destroy 
    @frove = FishRover.find(params[:id])
    # Successful deletion
    if @frove.destroy
      redirect_to '/fish_rovers', notice: "Fish rover deleted"
    # Error occurred
    else
      redirect_to '/fish_rovers', notice: "Error: fish rover not deleted"
    end
  end

  private

	def fish_rover_params
		params.require(:fish_rover).permit(:manager_id, :site_id, :user_id, 
			:date_completed, :begin_time, :oc_cc, :rep, :notes,
			rover_fishes_attributes: [:id, :fish_id, :abundance_index, :_destroy])
	end
end
