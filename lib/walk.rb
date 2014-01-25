require_relative "walk/version"


module Walk


  CURRENT_DIR = '.'
  PARENT_DIR  = '..'


  def self.walk(root, topdown: true, followlinks: false, &block)

    if block_given?
      inner_walk(root, topdown, followlinks, &block)
    else
      Enumerator.new do |enum|
        inner_walk(root, topdown, followlinks) do |path, dirs, files|
          enum << [path, dirs, files]
        end
      end      
    end

  end


  def self.inner_walk(root, topdown, followlinks, &block)

    dirs = []
    files = []
    path_to_explore = []

    begin
      Dir.entries(root).each do |entry|
        
        next if entry==CURRENT_DIR or entry==PARENT_DIR

        fullpath = File.join(root, entry)
        is_file, is_dir, go_down = inspect_entry(fullpath, followlinks)
        files << entry if is_file
        dirs << entry if is_dir
        path_to_explore << fullpath if go_down

      end        
    rescue Errno::ENOENT => e
      # current dir disapeared since parent scan, it's not an error
      return
    end

    yield  root, dirs, files  if topdown

    path_to_explore.each do |fullpath|
      inner_walk(fullpath, topdown, followlinks, &block)
    end

    yield  root, dirs, files  unless topdown

  end


  def self.inspect_entry(fullpath, followlinks)

    is_file = is_dir = go_down = false

    if File.file?(fullpath)
      is_file = true
    elsif File.directory?(fullpath)
      is_dir = true
      if (followlinks or not File.symlink?(fullpath)) and
        File.readable?(fullpath)
        go_down = true
      end
    end

    return is_file, is_dir, go_down

  rescue Errno::ENOENT => e
    return nil, nil, nil
  end

  private_class_method :inner_walk
  private_class_method :inspect_entry


end
