class TargetsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # POST /targets
  def create
    Target.create life_url: params[:lifeUrl], timeout: params[:timeout]
  end

  # GET /targets
  def get
    @targets = Target.all
    render json: @targets
  end

  # GET /targets/:id/diagnostics
  def getDiagnostics
    @diagnostics = Target.find(params[:id]).diagnostics
    render json: @diagnostics
  end

  private

  def record_not_found
    render nothing: true, status: 404
  end
end