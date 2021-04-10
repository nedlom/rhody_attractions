class RhodyAttractions::Attraction
  
  attr_accessor :name, :street_address, :town, :short_description, :long_description, :url, :website_url, :places_nearby
  
  @@all = []
  
  def self.all
    @@all
  end
  
  def initialize(name, town, short_description, url)
    @name = name
    @town = town
    @short_description = short_description
    @url = url
    self.class.all << self
  end
  
  def self.towns
    self.all.map {|a| a.town[/[^,]+/]}.uniq
  end
  
  def self.attractions_by_town(town)
    self.all.select do |a|
      a.town[/[^,]+/] == town
    end
  end
  
  def self.find_by_index(index)
    self.all[index - 1]
  end
  
  def self.find_by_name(name)
    self.all.detect do |a|
      a.name == name
    end
  end
  
  def street_address
    self.street_address = doc.css("address div").children.first.text
  end
  
  def website_url
    self.website_url = doc.css(".DDPageSiderail__website a")[0]['href']
  end
  
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