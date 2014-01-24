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
  end

  it 'should find all directories in directory tree'

  it 'should return an enumerator if no block is passed'

  it 'should return content from top to bottom by default'

  it 'should not explore symlink by default'

  it 'should explore symlink if needed'

  it 'should ignore disapearing entries'

end
