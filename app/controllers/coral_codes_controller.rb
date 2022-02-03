class CoralCodesController < ApplicationController
  before_action :require_user

  def index
    #@ccodes = CoralCode.order(group: :asc, code_name: :asc).all
    @ccodes = CoralCode.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end