class ESurveysController < ApplicationController
	before_action :require_user

  def new
    @esurv = ESurvey.new
    @eplot = @esurv.e_plots.build
    @eplotc = @eplot.e_plot_corals.build
    @eesa = @esurv.e_esa_pas.new(oann: 0, ofav: 0, ofra: 0, apal: 0, acer:0, apro: 0, dcyl: 0, mfer: 0, mmea: 0, dsto: 0, efas: 0, dead_APAL: 0, dead_DCYL: 0, rami: 0)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @esurv }
    end
  end

  def create
    @esurv = ESurvey.new( e_survey_params )

    respond_to do |format|
      # successful creation
      if @esurv.save
        format.html { redirect_to @esurv, notice: 'ECMP survey successfully created.' }
        format.json { render json: @esurv, status: :created, location: @esurv }
      # otherwise, print errors
      else
        format.html { render action: "new" }
        format.json { render json: @esurv.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @new_esurv = ESurvey.new # use in the view to render a form
    # Only show transects
    if @current_user.manager?
      @esurv = ESurvey.order(date_completed: :asc).all
      @filename = "all"
    else
      @esurv = @current_user.e_surveys.order(date_completed: :asc).all
      @filename = @current_user.name
    end

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @esurv.as_csv, filename: "ECMPSurvey_#{@filename}_#{Date.today}.csv" }
    end
  end

  def show
    @new_esurv = ESurvey.new # use in the view to render a form
    
    @esurv = ESurvey.find(params[:id])
    @eplots = @esurv.e_plots.all
    @eplotcs = @esurv.e_plot_corals.all
    @eesa = @esurv.e_esa_pas.all

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def edit
    @esurv = ESurvey.find(params[:id])
  end

  def update
    @esurv = ESurvey.find(params[:id])

    respond_to do |format|
      # successful update
      if @esurv.update(e_survey_params)
        format.html { redirect_to @esurv, notice: 'ECMP survey successfully updated.' }
        format.json { render json: @esurv, status: :created, location: @esurv }
      # Otherwise, print errors
      else
        format.html { render action: "edit" }
        format.json { render json: @esurv.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @esurv = ESurvey.find(params[:id])
    # Successful deletion
    if @esurv.destroy
      redirect_to '/e_surveys', notice: "ECMP survey deleted"
    # Error occurred
    else
      redirect_to '/e_surveys', notice: "Error: ECMP survey not deleted"
    end
  end

  private

  def e_survey_params
    params.require(:e_survey).permit(:fid, :user_id, :team, :role, :date_completed, :begin_time, :notes,
    	e_esa_pas_attributes: [:id, :oann, :ofav, :ofra, :apal, :acer, :apro, :dcyl, :mfer, :mmea, :dsto, :efas, :dead_APAL, :dead_DCYL, :rami, :_destroy ],
      e_plots_attributes: [:id, :plot, :habitat, :hardbottom, :coral_cover, :max_relief_cm, :min_depth, :max_depth, :_destroy, 
        e_plot_corals_attributes: [:id, :quadrant, :coral_code_id, :max_diam, :old_mortality, :new_mortality, :disease, :notes, :_destroy]])
  end
end
