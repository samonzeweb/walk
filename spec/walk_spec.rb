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
    path_order = Walk.walk(@test_path, topdown: false).map { |path,_,_| File.basename(path) }
    expect(path_order).to be == ['subdir_1', 'subdir_2', File.basename(@test_path)]
  end  

  it 'should not explore symlink by default' do
    add_simlink(@test_path)
    simlink_found = Walk.walk(@test_path).detect do |path,_,_|
      File.basename(path) == 'symlink'
    end
    expect(simlink_found).to be_nil
  end

  it 'should explore symlink if needed' do
    add_simlink(@test_path)
    simlink_found = Walk.walk(@test_path, followlinks: true).detect do |path,_,_|
      File.basename(path) == 'symlink'
    end
    expect(simlink_found).not_to be_nil 
  end

  it 'should ignore disapearing entries' do
    expect {
      Walk.walk(@test_path) do |path, subdirs, files|
        if path == @test_path
          remove_test_tree File.join(@test_path, 'subdir_2')
        end
      end
    }.not_to raise_error()  
  end

end
