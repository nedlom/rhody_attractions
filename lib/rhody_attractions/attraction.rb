class RhodyAttractions::Attraction
  
  attr_accessor :name, :street_address, :town, :short_description, :long_description, :url, :website_url, :places_nearby
  
  @@all = []
  
  def self.all
    @@all
  end
  
  def self.find_by_index(input)
    self.all[input - 1]
  end
  
  def self.find_by_name(name)
    self.all.detect do |a|
      a.name == name
    end
  end
  
  def self.max_name
    self.all.map do |a|
      a.name
    end
  end
  
  def initialize(name, town, short_description, url)
    @name = name
    @town = town
    @short_description = short_description
    @url = url
    self.class.all << self
  end
  
  def street_address
    self.street_address = doc.css("address div").children.first.text
  end
  
  def website_url
    if !doc.css(".DDPageSiderail__website a").empty?
      self.website_url = doc.css(".DDPageSiderail__website a")[0]['href']
    end
  end
  
  # def places_nearby
  #   doc.css(".DDPageSiderailRecirc__item-text").map do |a|
  #     name = a.children[1].text
  #     self.class.find_by_name(name)
  #   end.compact
  # end
  
  def places_nearby
    self.places_nearby = doc.css(".DDPageSiderailRecirc__item-text")
  end
  
  def long_description
    self.long_description = doc.css("#place-body p").text
  end
  
  def doc
    Nokogiri::HTML(open(url))
  end
  
  # a = RhodyAttractions::Attraction.all[0]
  #long_description .css("#place-body p").text
  #know before you go: .css(".DDP__direction-copy").text
end