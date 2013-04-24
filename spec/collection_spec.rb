require 'spec_helper.rb'

describe Grab::Collection do

  it 'should be available' do
    urls = %w(1 2 3 4)
    res = Grab::Collection.new urls

    res.available.count.should == urls.count
  end

end