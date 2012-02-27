require 'nokogiri'

require 'googleweather/daily_report'
require 'googleweather/current_report'

module Googleweather
  class WeatherData
    attr_reader :city, :postal_code, :latitude, :longitude, :forecast_date, :current_date, :units, :xml
    
    DAYS = {
      :sun  => DailyReport.new,
      :mon  => DailyReport.new,
      :tue  => DailyReport.new,
      :wed  => DailyReport.new,
      :thu  => DailyReport.new,
      :fri  => DailyReport.new,
      :sat  => DailyReport.new
    }
    
    def initialize(xml)
      @xml = xml
      #feed = Nokogiri::XML(xml)
      
      #if feed
      #  @data = feed.at_css('weather')
      #  
      #  fi = @data.at_css('forecast_information')
      #  @city          = node_data(fi, 'city')
      #  @postal_code   = node_data(fi, 'postal_code')
      #  @units         = node_data(fi, 'unit_system_data')
      #  @latitude      = node_data(fi, 'latitude_e6')
      #  @longitude     = node_data(fi, 'longitude_e6')
      #  @forecase_date = node_data(fi, 'forecast_date')
      #  @current_date  = node_data(fi, 'current_date_time')
      
       # update_current_conditions
       # update_forecast
      #end  
    end  
    
    def now
      @current_conditions ||= update_current_conditions
    end  
    
    def forecast
      @forecast ||= update_forecast
    end  
    
    def update_forecast
      forecast = @data.css('forecast_conditions')
      
      forecast.each do |day|
        day_of_week = node_data(day, 'day_of_week')

        
        DAYS[day_of_week.downcase.to_sym] = DailyReport.new({
          :day         => day_of_week,
          :low         => node_data(day, 'low'),
          :high        => node_data(day, 'high'),
          :img         => google_image_url(node_data(day, 'icon')),
          :condition   => node_data(day, 'condition')
        })
      end  
      
      @forecast = DAYS
    end  
    
    def update_current_conditions
      cc = @data.at_css('current_conditions')
      

      
      @current_conditions = CurrentReport.new({
          :condition => node_data(cc, 'condition'),
          :temp_f    => node_data(cc, 'temp_f'), 
          :temp_c    => node_data(cc, 'temp_c'),
          :humidity  => parse_percentage(node_data(cc, 'humidity')),
          :wind      => parse_wind(node_data(cc, 'wind_condition')),
          :img       => google_image_url(node_data(cc, 'icon'))
      })      
    end  
    
    private
    
    def parse_percentage(str)
      /\d*%/.match(str).to_s
    end
    
    def google_image_url(relative_path)
      'http://www.google.com' + relative_path
    end  
    
    def parse_wind(str)
      str.gsub('Wind: ', '')
    end  
    
    def node_data(xml, node)
      noko = xml.at_css(node)
      noko ? noko[:data] : ""
    end  
  end  
end  