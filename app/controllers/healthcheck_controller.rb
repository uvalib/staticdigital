class HealthcheckController < ApplicationController

  #skip_before_filter :require_auth

  # the basic health status object
  class Health
    attr_accessor :healthy
    attr_accessor :message

    def initialize( status, message )
      @healthy = status
      @message = message
    end

  end

  # the response
  class HealthCheckResponse
    attr_accessor :env_content_dir
    attr_accessor :env_dl_url

    def is_healthy?
      env_content_dir.healthy && env_dl_url.healthy
    end
  end

  # # GET /healthcheck
  # # GET /healthcheck.json
  def index
    status = get_health_status( )
    response = make_response( status )
    render json: response, :status => response.is_healthy? ? 200 : 500
  end

  private

  def get_health_status
    status = {}

    # check environment variables
    msg = ''
    msg = !ENV['CONTENT_DIRECTORY'].nil? ? '' : 'Environment variable CONTENT_DIRECTORY is not defined.'
    status[:env_content_dir] = Health.new(!ENV['CONTENT_DIRECTORY'].nil?, msg)

    msg = !ENV['CONTENT_DOWNLOAD_URL'].nil? ? '' : 'Environment variable CONTENT_DOWNLOAD_URL is not defined.'
    status[:env_dl_url] = Health.new(!ENV['CONTENT_DOWNLOAD_URL'].nil?, msg)

    return( status )
  end

  def make_response( health_status )
    r = HealthCheckResponse.new
    r.env_content_dir = health_status[ :env_content_dir ]
    r.env_dl_url = health_status[ :env_dl_url ]
    return( r )
  end

end