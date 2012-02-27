require 'googleweather/weather_data'
require 'googleweather/feed'

module Googleweather
  class Client
    attr_accessor :city, :zip_code
    attr_reader   :weather, :feed
    
    def initialize(city_or_zip)
      if /\A\d{5}\z/ =~ city_or_zip
        @zip_code = city_or_zip 
      else
        @city = city_or_zip
      end
      
      @errors = []  
    end
    
    def weather
      if feed.response_code == 200
        @weather = WeatherData.new(feed.body) 
      else
        @weather = nil
      end  
    end 
    
    def feed
      @feed = Feed.new(@city || @zip_code)
    end     

    def city=(city)
      reset
      @city = city
    end  
    
    def zip_code=(zip_code)
      reset
      @zip_code = zip_code
    end      
    
    def reset
      @city, @weather, @zip_code = nil
    end  
  end   
end  