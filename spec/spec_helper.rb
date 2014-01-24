require 'tmpdir'

RSpec.configure do |config|
  config.color_enabled = true
end


def create_test_tree
  tmpdir = Dir.mktmpdir
  FileUtils.touch File.join(tmpdir, "dummy.txt")

  subdir_1 = File.join(tmpdir, 'subdir_1')
  Dir.mkdir(subdir_1)
  FileUtils.touch File.join(subdir_1, "dummy_1.txt")
  FileUtils.touch File.join(subdir_1, "dummy_2.txt")

  subdir_2 = File.join(tmpdir, 'subdir_2')
  Dir.mkdir(subdir_2)
  FileUtils.touch File.join(subdir_1, "dummy.txt")

  tmpdir
end

def remove_test_tree(path)
  must_begin_with = Dir.tmpdir + File::SEPARATOR
  raise "Path not in temporary directory !" unless path.index(must_begin_with) == 0
  FileUtils.rm_r(path)
end

def add_simlink(path)
  File.symlink File.join(path, 'subdir_2'), File.join(path, 'symlink')
end


