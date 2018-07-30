class Content
  include  ActiveModel::Model

  attr_accessor :id
  attr_accessor :public
  attr_accessor :file

  def save
    # set the destination path to write the file
    dest_path = File.join(Content.content_dir,  @public=='1' ? 'public' : 'uva', next_id, @file.original_filename.to_s)
    # Save the file
    puts "save #{@id},#{@public},#{@file.tempfile.path.inspect}----"
    puts dest_path

    FileUtils.makedirs File.dirname(dest_path)
    FileUtils.mv(@file.tempfile.path, dest_path)
    FileUtils.chmod 0644, dest_path
  end

  # Find and list all files
  # Create a class wide method that's not limited to an object of class. use self.methodname
  def self.all
    result = []
    public = Dir.glob(File.join(File.join(content_dir, "public"), File.join("**", "*.*")))
    uva = Dir.glob(File.join(File.join(content_dir, "uva"), File.join("**", "*.*")))
    all = public + uva
    all.each do | pdf |
      path_array = pdf.split('/')
      pdf_link = File.join(ENV['CONTENT_DOWNLOAD_URL'], (path_array[-3] == 'uva') ? 'uva' : '', path_array[-2])
      result << { id: path_array[-2], "path": pdf_link, "uva-only": (path_array[-3] == 'uva') }
    end
    result
  end

  def self.content_dir
    content_dir = ENV['CONTENT_DIRECTORY']
    if !content_dir.nil? && !content_dir.empty?
      return content_dir
    else
      return "content"
    end
  end

  def current_id
    id_list = Content.all.collect {|x| x[:id].gsub(/[^\d]/,'')}
    current_id = id_list.max
    current_id
  end

  # Find the next valid id
  def next_id
    next_id = "sdc:" + (current_id.to_i + 1).to_s
    next_id
  end

  def get_url
    File.join(ENV['CONTENT_DOWNLOAD_URL'], "sdc:"+ current_id.to_s)
  end

end
