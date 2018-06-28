class Content
  include  ActiveModel::Model

  attr_accessor :id
  attr_accessor :public
  attr_accessor :file

  def save
    # set the destination path to write the file
    dest_path = File.join(content_dir,  @public ? 'public' : 'uva', next_id.to_s, @file.original_filename.to_s)
    # Save the file
    puts "save #{@id},#{@public},#{@file.tempfile.path.inspect}----"
    puts dest_path

    FileUtils.makedirs File.dirname(dest_path)
    FileUtils.mv(@file.tempfile.path, dest_path)
  end

  def all
    # TODO: Find and list all files
    []
  end

  def content_dir
    content_dir = ENV['CONTENT_DIRECTORY']
    if !content_dir.nil? && !content_dir.empty?
      return content_dir
    else
      return "content"
    end
  end

  def next_id
    # Todo: find the next id
    100
  end
end