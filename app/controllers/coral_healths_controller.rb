class CoralHealthsController < ApplicationController
  before_action :require_user

  def new
    @chealth = CoralHealth.new
    @chealth.transect_corals.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chealth }
    end
  end

  def create
    @chealth = CoralHealth.new( coral_health_params )

    respond_to do |format|
      # successful creation
      if @chealth.save
        format.html { redirect_to @chealth, notice: 'Coral health successfully created.' }
        format.json { render json: @chealth, status: :created, location: @chealth }
      # otherwise, print errors
      else
        format.html { render action: "new" }
        format.json { render json: @chealth.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @new_chealth = CoralHealth.new # use in the view to render a form
    # Only show transects
    if @current_user.manager?
      @chealth = CoralHealth.order(date_completed: :asc).all
      @filename = "all"
    else
      @chealth = @current_user.coral_healths.order(date_completed: :asc).all
      @filename = @current_user.name
    end

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @chealth.as_csv, filename: "CoralHealth_#{@filename}_#{Date.today}.csv" }
    end
  end

  def show
    @chealth = CoralHealth.find(params[:id])
    @trancs = @chealth.transect_corals.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def edit
    @chealth = CoralHealth.find(params[:id])
  end

  def update
    @chealth = CoralHealth.find(params[:id])

    respond_to do |format|
      # successful update
      if @chealth.update(coral_health_params)
        format.html { redirect_to @chealth, notice: 'Coral health successfully updated.' }
        format.json { render json: @chealth, status: :created, location: @chealth }
      # Otherwise, print errors
      else
        format.html { render action: "edit" }
        format.json { render json: @chealth.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @chealth = CoralHealth.find(params[:id])
    # Successful deletion
    if @chealth.destroy
      redirect_to '/coral_healths', notice: "Coral health deleted"
    # Error occurred
    else
      redirect_to '/coral_healths', notice: "Error: coral health not deleted"
    end
  end

  private

  def coral_health_params
    params.require(:coral_health).permit(:manager_id, :site_id, :user_id, :date_completed, :rep, :notes, 
      transect_corals_attributes: [:id, :coral_code_id, :length_cm, :width_cm, :height_cm, :_destroy])
  end
end