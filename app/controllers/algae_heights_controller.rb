class AlgaeHeightsController < ApplicationController
  before_action :require_user

  def new
    @aht = AlgaeHeight.new
    @aht.transect_algaes.build

    respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @aht }
      end
  end

  def create
    @aht = AlgaeHeight.new( algae_height_params )

    respond_to do |format|
      # successful creation
      if @aht.save
        format.html { redirect_to @aht, notice: 'Algae heights successfully created.' }
        format.json { render json: @aht, status: :created, location: @aht }
      # otherwise, print errors
      else
        format.html { render action: "new" }
        format.json { render json: @aht.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @new_aht = AlgaeHeight.new # use in the view to render a form
    # Only show transects
    if @current_user.manager?
      @aht = AlgaeHeight.order(date_completed: :asc).all
      @filename = "all"
    else
      @aht = @current_user.algae_heights.order(date_completed: :asc).all
      @filename = @current_user.name
    end

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @aht.as_csv, filename: "AlgaeHeights_#{@filename}_#{Date.today}.csv" }
    end
  end
  
  def show
    @aht = AlgaeHeight.find(params[:id])
    @tranas = @aht.transect_algaes.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def edit
    @aht = AlgaeHeight.find(params[:id])
  end

  def update
    @aht = AlgaeHeight.find(params[:id])

    respond_to do |format|
      # successful update
      if @aht.update(algae_height_params)
        format.html { redirect_to @aht, notice: 'Algae heights successfully updated.' }
        format.json { render json: @aht, status: :created, location: @aht }
      # Otherwise, print errors
      else
        format.html { render action: "edit" }
        format.json { render json: @aht.errors, status: :unprocessable_entity }
      end
    end
   end

   def destroy 
    @aht = AlgaeHeight.find(params[:id])
    #@boatlog.destroy
    # Successful deletion
    if @aht.destroy
      redirect_to '/algae_heights', notice: "Algae heights deleted"
    # Error occurred
    else
      redirect_to '/algae_heights', notice: "Error: algae heights not deleted"
    end
  end

  private

  def algae_height_params
    params.require(:algae_height).permit(:manager_id, :site_id, :user_id, :date_completed, :rep, :notes, 
      transect_algaes_attributes: [:id, :algae_id, :height_cm, :_destroy])
  end
end