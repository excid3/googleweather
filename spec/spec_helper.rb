require 'rubygems'
require 'minitest/autorun'
require 'mocha'
require 'vcr'

require 'googleweather'

VCR.config do |c|
  c.cassette_library_dir = File.join(File.expand_path( File.dirname(__FILE__) ), 'fixtures', 'vcr_cassettes')
  c.stub_with :webmock # or :fakeweb
end
 