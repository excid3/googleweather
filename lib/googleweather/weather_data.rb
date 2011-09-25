require 'nokogiri'
require_relative 'daily_report'
require_relative 'current_report'

module Googleweather
  class WeatherData
    attr_reader :city, :postal_code, :latitude, :longitude, :forecast_date, :current_date, :units
    
    DAYS = {
      :sun  => DailyReport.new,
      :mon  => DailyReport.new,
      :tue  => DailyReport.new,
      :wed  => DailyReport.new,
      :thur => DailyReport.new,
      :fri  => DailyReport.new,
      :sat  => DailyReport.new
    }
    
    def initialize(xml)
      feed = Nokogiri::XML(xml)
      @data = feed.at_css('weather')
      
      fi = @data.at_css('forecast_information')
      @city          = node_data(fi, 'city')
      @postal_code   = node_data(fi, 'postal_code')
      @units         = node_data(fi, 'unit_system_data')
      @latitude      = node_data(fi, 'latitude_e6')
      @longitude     = node_data(fi, 'longitude_e6')
      @forecase_date = node_data(fi, 'forecast_date')
      @current_date  = node_data(fi, 'current_date_time')
      
      update_current_conditions
      update_forecast
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
          :img         => node_data(day, 'icon'),
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
          :humidity  => node_data(cc, 'humidity'),
          :window    => node_data(cc, 'wind'),
          :img       => node_data(cc, 'icon')
      })      
    end  
    
    private
    
    def node_data(xml, node)
      puts "Parsing #{node}"
      
      noko = xml.at_css(node)
      noko ? noko[:data] : ""
    end  
  end  
end  