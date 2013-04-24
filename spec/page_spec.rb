require 'spec_helper'

describe Grab::Page do

  before :all do
    @images = %w(1.jpg 2.jpg 3.jpg 3.jpg 2.jpg 1.jpg)

    @address = 'http://www.example.com'
    @url = URI.parse @address
    @html = @images.map{|i| "<img src='#{i}'></img>"}.join
  end

  it "should have image list" do

    page = Grab::Page.new @address
    page.stub(:html).and_return(@html)

    res = @images.map{|i| @url.merge i }
    page.images.should == res.uniq
  end


end