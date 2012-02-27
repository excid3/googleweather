require 'spec_helper'
require 'uri'

describe Googleweather::Feed do
  before do
    @feed = Googleweather::Feed.new("Philadelphia")
  end  
  
  it "can be initialized with a string" do
    @feed.must_be_instance_of Googleweather::Feed
  end
  
  describe "#url" do
    it "concatenates base api url with query parameter" do
      @feed.url.must_equal URI.parse("http://www.google.com/ig/api?weather=Philadelphia")
    end
    
    it "returns an URI object" do
      @feed.url.must_be_instance_of URI::HTTP
    end    
  end
  
  describe "#response_code" do
    it "returns response code" do
      VCR.use_cassette('Philadelphia') do
        @feed.response_code.must_equal "200"
      end
    end  
  end  
  
  describe "#body" do
    it "returns response body" do
      VCR.use_cassette('Philadelphia') do
        @feed.body.must_equal "<?xml version=\"1.0\"?><xml_api_reply version=\"1\">" <<
          "<weather module_id=\"0\" tab_id=\"0\" mobile_row=\"0\" mobile_zipped=\"1\" row=\"0\" section=\"0\" >" <<
          "<forecast_information><city data=\"Philadelphia, PA\"/><postal_code data=\"Philadelphia\"/>" << 
          "<latitude_e6 data=\"\"/><longitude_e6 data=\"\"/><forecast_date data=\"2012-02-26\"/>" <<
          "<current_date_time data=\"2012-02-27 01:54:00 +0000\"/><unit_system data=\"US\"/>" <<
          "</forecast_information><current_conditions><condition data=\"Clear\"/><temp_f data=\"38\"/>" <<
          "<temp_c data=\"3\"/><humidity data=\"Humidity: 62%\"/><icon data=\"/ig/images/weather/sunny.gif\"/>" <<
          "<wind_condition data=\"Wind: S at 7 mph\"/></current_conditions><forecast_conditions>" <<
          "<day_of_week data=\"Sun\"/><low data=\"34\"/><high data=\"47\"/><icon data=\"/ig/images/weather/sunny.gif\"/>" <<
          "<condition data=\"Clear\"/></forecast_conditions><forecast_conditions><day_of_week data=\"Mon\"/><low data=\"36\"/>" <<
          "<high data=\"57\"/><icon data=\"/ig/images/weather/sunny.gif\"/><condition data=\"Clear\"/></forecast_conditions>" <<
          "<forecast_conditions><day_of_week data=\"Tue\"/><low data=\"37\"/><high data=\"50\"/>" << 
          "<icon data=\"/ig/images/weather/sunny.gif\"/><condition data=\"Clear\"/></forecast_conditions><forecast_conditions>" << 
          "<day_of_week data=\"Wed\"/><low data=\"39\"/><high data=\"48\"/><icon data=\"/ig/images/weather/chance_of_rain.gif\"/>" <<
          "<condition data=\"Chance of Rain\"/></forecast_conditions></weather></xml_api_reply>"
      end    
    end    
  end
  
  describe "#get" do
    it "retrieves feed from url" do
      url = URI.parse("http://www.google.com/ig/api?weather=Philadelphia")
      Net::HTTP.expects(:get_response).with(url).returns(stub(:body => "", :code => 200))
      @feed.get!
    end
    
    it "sets body" do      
      VCR.use_cassette('Philadelphia') do
        @feed.get!
      end
      @feed.body.wont_be_nil
    end
    
    it "sets response code" do      
      VCR.use_cassette('Philadelphia') do
        @feed.get!
      end  
      @feed.response_code.wont_be_nil      
    end    
    
    it "sets errors to false if response is valid" do      
      VCR.use_cassette('Philadelphia') do
        @feed.get!
        @feed.error.must_equal false
      end
    end
    
    it "sets errors to true if response is invalid" do
      VCR.use_cassette('error') do
        @feed.get!
        @feed.error.must_equal true
      end
    end        
  end        
end
  