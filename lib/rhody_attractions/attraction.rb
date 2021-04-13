class RhodyAttractions::Attraction
  
  attr_accessor :name, :street_address, :town, :short_description, :long_description, :url, :website_url, :places_nearby, :know_before_you_go
  
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
  
  def places_nearby
    doc.css(".DDPageSiderailRecirc__item-text").map do |a|
      name = a.children[1].text
      self.class.find_by_name(name)
    end.compact
  end
  
  def long_description
    self.long_description = doc.css("#place-body p").text
  end
  
  def know_before_you_go
    if !doc.css(".DDP__direction-copy").empty?
      self.know_before_you_go = doc.css(".DDP__direction-copy p").text
    end
  end
  
  def print_description(size)
    header = "#{self.class.all.index(self) + 1}. #{self.name} - #{self.town}"
    puts header
    puts "#{"-" * header.length}"
    if size == "short"
      self.short_description.scan(/(.{1,55})(?:\s|$)/m).each do |b|
        puts b[0].strip
      end
    else
      self.long_description.scan(/(.{1,55})(?:\s|$)/m).each do |b|
        puts b[0].strip
      end
    end
  end
  
  def doc
    Nokogiri::HTML(open(url))
  end
  
  # a = RhodyAttractions::Attraction.all[0]
  #long_description .css("#place-body p").text
  #know before you go: .css(".DDP__direction-copy").text
end