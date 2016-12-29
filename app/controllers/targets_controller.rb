class TargetsController < ApplicationController
  def get
    @targets = Target.all
    respond_to do |format|
      format.json { render json: @targets }
    end
  end
end