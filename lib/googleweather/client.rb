require 'net/http'
require 'uri'
require_relative 'weather_data'

module Googleweather
  class Client
    attr_accessor :city, :zip
    attr_reader :weather

    BASE_URL = 'http://www.google.com/ig/api?weather='    
    
    def initialize(city_or_zip)
      if city_or_zip.to_i == 0
        @city = city_or_zip
      else
        @zip = city_or_zip
      end    
      
      update_weather    
    end
    
    def now
      @weather.now
    end
    
    def forecast
      @weather.forecast
    end    
    
    def update_weather
      @weather = WeatherData.new(get)
    end    
    
    def url
      URI.parse(BASE_URL + (@city || @zip))
    end 
    
    def get
      resp = Net::HTTP.get_response(url)
      
      if resp.code == "200"
        resp.body
      else
        puts "error retrieving weather feed"
      end    
    end   
  end   
end  