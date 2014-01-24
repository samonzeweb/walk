require_relative "walk/version"

module Walk

  CURRENT_DIR = '.'
  PARENT_DIR  = '..'

  def self.walk(root, topdown=true, followlinks=false, &block)

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

    yield  root, dirs, files  if topdown

    path_to_explore.each do |fullpath|
      inner_walk(fullpath, topdown, followlinks, &block)
    end

    yield  root, dirs, files  unless topdown

  end

  private_class_method :inner_walk

end
