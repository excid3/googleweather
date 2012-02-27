require 'spec_helper'

describe Googleweather do
  it "initalizes a client" do
    Googleweather.new('').must_be_instance_of Googleweather::Client
  end  
end  
