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
    id_in_collection = Content.all.select {|x| x[:id] == id}
    if !id_in_collection.empty?
        r = {
          identifier: [id],
          access_url: [File.join(ENV['CONTENT_DOWNLOAD_URL'], id)],
          master_file: Dir.glob(File.join((File.join(ENV['CONTENT_DIRECTORY'],id_in_collection[0][:"uva-only"] ? "uva" : "public", id)),File.join("*.pdf")))
        }
    end
    r[:access_restriction] = "uva" if (!id_in_collection.empty? && id_in_collection[0][:"uva-only"]== true)
    return r
  end

end