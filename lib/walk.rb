require "walk/version"

module Walk

  CURRENT_DIR = '.'
  PARENT_DIR  = '..'

  def self.walk(root, topdown=true, followlinks=false)
    Enumerator.new do |enum|
      inner_walk(enum, root, topdown=true, followlinks=false)
    end
  end

  def self.inner_walk(enum, root, topdown=true, followlinks=false)

    dirs = []
    files = []
    path_to_explore = []

    Dir.entries(root).each do |entry|
      
      next if entry==CURRENT_DIR or entry==PARENT_DIR

      fullpath = File.join(root, entry)
      if File.file?(fullpath)
        files << entry
      elsif File.directory?(fullpath)
        dirs << entry
        if (followlinks or not File.symlink?(fullpath)) and
           File.readable?(fullpath)
          path_to_explore << fullpath 
        end
      end

    end

    enum << [root, dirs, files] if topdown

    path_to_explore.each do |fullpath|
      inner_walk(enum, fullpath, topdown, followlinks)
    end

    enum << [root, dirs, files] unless topdown

  end

  private_class_method :inner_walk

end
