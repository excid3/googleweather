module Googleweather
  class DailyReport
    attr_accessor :day, :high, :low, :condition, :img
    
    def initialize(data = {})
      @day  = data[:day]
      @high = data[:high]
      @low  = data[:low]
      @img  = data[:img]
      @condition = data[:condition]
    end  
  end  
end