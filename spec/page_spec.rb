require 'spec_helper'

describe Grab::Page do

  before :all do
    @images = %w(1.jpg 2.jpg 3.jpg)*2

    @address = 'http://www.example.com'
    @url = URI.parse @address
    @html = @images.map{|i| "<img src='#{i}'></img>"}.join
    @result = @images.map{|i| @url.merge i }

  end

  it "should have image list" do

    page = Grab::Page.new @address
    page.stub(:html).and_return(@html)

    page.images.should == @result.uniq
  end


end