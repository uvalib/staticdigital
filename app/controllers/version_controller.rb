class VersionController < ApplicationController

  #skip_before_filter :require_auth

  # # GET /version
  # # GET /version.json
  def index
    response = Sdc::Application::VERSION
    render json: response, :status => 200
  end

end