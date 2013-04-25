require 'spec_helper'

describe Grab::Manager do

  before :all do
    @files = %w(1.jpg 2.jpg 3.jpg)
    @tmp_folder = File.join Dir.pwd, "manager_spec_img_#{Time.now}"
    @links = @files.map{|f| "http://example.com/#{f}" }
  end

  after :all do
    FileUtils.rm_rf @tmp_folder
  end

  it 'should download images' do
    manager = Grab::Manager.new :links => @links,
                                :folder => @tmp_folder
    manager.start_download!

    result = Dir.entries(@tmp_folder).reject{|entry| entry == '.' || entry == '..'}
    result.sort.should == @files.sort
  end

end