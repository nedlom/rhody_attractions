require_relative "./rhody_attractions/version"
require_relative "./rhody_attractions/attraction.rb"
require_relative "./rhody_attractions/cli.rb"
require_relative "./rhody_attractions/scraper.rb"

require 'pry'
require 'nokogiri'
require 'open-uri'

module RhodyAttractions
  class Error < StandardError; end
  # Your code goes here...
end
