require 'spec_helper'
require 'walk'

describe Walk do

  before :each do
    @test_path = create_test_tree
  end

  after :each do
    remove_test_tree @test_path
  end

  it 'should find all files in directory tree' do
    files_count = 0
    Walk.walk(@test_path) do |path, subdirs, files|
      files_count += files.length
    end
    expect(files_count).to be == 4
  end

  it 'should find all directories in directory tree' do
    dirs_count = 0
    Walk.walk(@test_path) do |path, subdirs, files|
      dirs_count += subdirs.length
    end
    expect(dirs_count).to be == 2
  end

  it 'should return an enumerator if no block is passed' do
    expect(Walk.walk(@test_path)).to be_an(Enumerator)
  end

  it 'should give same result with enumerator than with block style' do
    files_count = Walk.walk(@test_path).map { |_,_,f| f.length}.reduce(:+)
    expect(files_count).to be == 4
  end  

  it 'should return content from top to bottom by default' do
    path_order = Walk.walk(@test_path).map { |path,_,_| File.basename(path) }
    expect(path_order).to be == [File.basename(@test_path), 'subdir_1', 'subdir_2']
  end

  it 'should return content from bottom to top if speficied' do
    path_order = Walk.walk(@test_path, false).map { |path,_,_| File.basename(path) }
    expect(path_order).to be == ['subdir_1', 'subdir_2', File.basename(@test_path)]
  end  

  it 'should not explore symlink by default'

  it 'should explore symlink if needed'

  it 'should ignore disapearing entries'

end
