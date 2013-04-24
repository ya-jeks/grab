require 'spec_helper'

describe Grab::Resource do

  it 'should be available' do
    res = Grab::Resource.new ''
    res.state.should == 'available'
  end

end