require 'googleweather/version'
require 'googleweather/client'

module Googleweather
  def self.new(city_or_zip)
    Client.new(city_or_zip)
  end  
end
