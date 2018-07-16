class Content
  include  ActiveModel::Model

  attr_accessor :id
  attr_accessor :public
  attr_accessor :file

  def save
    # set the destination path to write the file
    dest_path = File.join(Content.content_dir,  @public=="1" ? 'public' : 'uva', next_id.to_s, @file.original_filename.to_s)
    # Save the file
    puts "save #{@id},#{@public},#{@file.tempfile.path.inspect}----"
    puts dest_path

    FileUtils.makedirs File.dirname(dest_path)
    FileUtils.mv(@file.tempfile.path, dest_path)
  end

  # Find and list all files
  # Create a class wide method that's not limited to an object of class. use self.methodname
  def self.all
    # TODO: Find and list all files
    result = []
    public = Dir.glob(File.join(File.join(content_dir, "public"), File.join("**", "*.*")))
    uva = Dir.glob(File.join(File.join(content_dir, "uva"), File.join("**", "*.*")))
    all = public + uva
    all.each do | pdf |
      path_array = pdf.split('/')
      result << { id: path_array[-2], "path": pdf, "uva-only": (path_array[-3] == 'uva') }
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

  # Find the next valid id
  def next_id
    # Todo: find the next id
    id_list = Content.all.collect{|x| x[:id]}
    next_id = id_list.max.to_i + 1
    next_id
  end
end