require 'tmpdir'

RSpec.configure do |config|
  config.color_enabled = true
end


def create_test_tree
  tmpdir = Dir.mktmpdir
  # TODO : build a tree with subdirs, files and symlink
  tmpdir
end


def remove_test_tree(path)
  must_begin_with = Dir.tmpdir + File::SEPARATOR
  raise "Path not in temporary directory !" unless path.index(must_begin_with) == 0
  FileUtils.rm_r(path)
end



