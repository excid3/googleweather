module Googleweather
  class CurrentReport
    attr_accessor :temp_f, :temp_c, :humidity, :wind, :img
    
    def initialize(data = {})
      @temp_f      = data[:temp_f]
      @temp_c      = data[:temp_c]
      @humidity    = data[:humidity]
      @wind        = data[:wind]
      @img         = data[:img]
      @condition   = data[:condition]
    end 
    
    def temp
      @temp_f
    end   
  end  
end