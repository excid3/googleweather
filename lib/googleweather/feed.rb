require 'net/http'
require 'uri'

module Googleweather
  class Feed
    BASE_URL = 'http://www.google.com/ig/api?weather='

    attr_accessor :query_param
    attr_reader   :error

    def initialize(query_param)
      @query_param = query_param
    end

    def url
      URI.parse(BASE_URL + query_param)
    end

    def body
      get! if @body.nil?

      @body
    end

    def response_code
      if @response_code.nil?
        get!
      end

      @response_code
    end

    def get!
      response = Net::HTTP.get_response(url)

      @body          = response.body
      @response_code = response.code.to_i

      if @response_code == 200
        @error = false
      else
        @error = true
      end
    end
  end
end

