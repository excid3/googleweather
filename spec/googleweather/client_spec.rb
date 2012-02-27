require 'spec_helper'

describe Googleweather::Client do
  before do
    @client = Googleweather::Client.new("Philadelphia")
  end  
  
  it "can be initalized with a city" do      
    @client.must_be_instance_of Googleweather::Client
    @client.city.must_equal "Philadelphia"
    @client.zip_code.must_be_nil
  end
  
  it "can be initialized with a zip code" do
    client = Googleweather::Client.new("19002")
    
    client.must_be_instance_of Googleweather::Client
    client.zip_code.must_equal "19002"
    client.city.must_be_nil
  end 
  
  describe "#weather" do
    it "is WeatherData if retrieving feed is successful" do
      @client.stubs(:feed).returns(stub(:response_code => 200, :body => 'weather'))
      @client.weather.must_be_instance_of Googleweather::WeatherData
    end
    
    it "is nil if retrieving feed failed" do
      @client.stubs(:feed).returns(stub(:response_code => 404))
      @client.weather.must_be_nil      
    end    
  end  
  
  describe "#feed" do
    it "is a Feed" do
      @client.feed.must_be_instance_of Googleweather::Feed
    end  
  end  
    
  describe "#zip_code=" do
    it "sets the zip code and unsets the city" do
      @client.zip_code = "12345"
      
      @client.zip_code.must_equal "12345"
      @client.city.must_be_nil
    end  
  end  
  
  describe "#city=" do
    it "sets the city and unsets zip code" do
      @client.city = "NYC"
      
      @client.city.must_equal "NYC"
      @client.zip_code.must_be_nil
    end
  end  
  
  describe "#reset" do
    it "resets previously retrieved weather data" do
      feed = stub(:response_code => 200, :body => 'weather')
      
      Googleweather::Feed.stubs(:new).returns(feed)
      Googleweather::WeatherData.stubs(:new)
      
      @client.reset
      @client.zip_code.must_be_nil
      @client.city.must_be_nil
      @client.weather.must_be_nil
    end  
  end        
end