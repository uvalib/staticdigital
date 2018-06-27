class StaticdcsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_staticdc, only: [:show, :edit, :update, :destroy]

  @sdc_dir = ENV['STATICDIGITAL_PDF_DIR'] || 'default-content-directory'

  # GET /staticdcs
  # GET /staticdcs.json
  def index
    @staticdcs = Staticdc.all
    
    @public_pdf_address = display_pdfs("public")
  #  @uva_pdf_address = display_pdfs(uva)

  end

  # GET /staticdcs/1
  # GET /staticdcs/1.json
  def show
  end

  # GET /staticdcs/new
  def new
    @staticdc = Staticdc.new
  end

  # GET /staticdcs/1/edit
  def edit

  end

  # POST /staticdcs
  # POST /staticdcs.json
  def create
    @staticdc = Staticdc.new(staticdc_params)
    @staticdc.pdf.attach(staticdc_params[:pdf])

    respond_to do |format|
      if @staticdc.save
        format.html { redirect_to @staticdc, notice: 'Staticdc was successfully created.' }
        format.json { render :show, status: :created, location: @staticdc }
      else
        format.html { render :new }
        format.json { render json: @staticdc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staticdcs/1
  # PATCH/PUT /staticdcs/1.json
  def update
    respond_to do |format|
      if @staticdc.update(staticdc_params)
        format.html { redirect_to @staticdc, notice: 'Staticdc was successfully updated.' }
        format.json { render :show, status: :ok, location: @staticdc }
      else
        format.html { render :edit }
        format.json { render json: @staticdc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staticdcs/1
  # DELETE /staticdcs/1.json
  def destroy
    @staticdc.destroy
    respond_to do |format|
      format.html { redirect_to staticdcs_url, notice: 'Staticdc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def current_dir
    Dir.pwd
  end

  # returns a hash containing all the PDFs in the system in the
  # format [ {id: "sdc:1", path: "/path/to/pdf", "uva-only": false}, 
  #          {id: "sdc:2", path: "/path/to/pdf", "uva-only": true } ]
  def list_pdfs() 
    result = []
    public = Dir.glob(File.join(File.join(@sdc_dir, "public"), File.join("**", "*.*")))
    uva = Dir.glob(File.join(File.join(@sdc_dir, "uva"), File.join("**", "*.*")))
    all = public + uva
    all.each do | pdf |
       path_array = pdf.split('/')
       result << { id: path_array[-2], "path": pdf, "uva-only": (path_array[-3] == 'uva') }
    end
    result
  end

  def display_pdfs(subdir)
    Dir.chdir(@sdc_dir + "#{subdir}")
    Dir.foreach(".") do |f|
      Dir.chdir(@sdc_dir + "#{subdir}/#{f}")
      unless f.start_with?('.')
        Dir.foreach(".") do |pdf|
          return f + "/" + pdf unless pdf.start_with?('.')
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staticdc
      @staticdc = Staticdc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staticdc_params
      params.require(:staticdc).permit(:name, :public, :address, :pdf)
    end
end
