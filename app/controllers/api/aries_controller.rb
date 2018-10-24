class Api::AriesController < ApplicationController
  def index
    render plain: "Static Digital Aries API", status: :ok
  end

  def show
    id = params[:id]
    response = get_sdc(id)
    if response.nil?
      render plain: "#{params[:id]} not found", status: :not_found
    else
      render json: response
    end
  end

  private
  def get_sdc(id)
    content = Content.find(id)
    r = {
        identifier: id,
        access_url: "http://digital.lib.virginia.edu/sdc:1",
        master_file: "/lib_content44/PDF_archive/public/sdc:1/African-Americanfile-index.pdf"
    }
  end
end