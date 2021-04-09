class RhodyAttractions::Scraper
  
  attr_accessor :site_url
  
  #(".page a")
  def initialize
    @site_url = "https://www.atlasobscura.com/things-to-do/rhode-island/places"
  end
  
  def get_page
    Nokogiri::HTML(open(site_url))
  end
    
  def make_page
    nokogiri_object = get_page
    attraction_nodes = nokogiri_object.css(".CardWrapper")
    attraction_nodes.each do |a|
      name = a.css("span").text
      town = a.css(".Card__hat").text
      short_description = a.css(".Card__content").text
      path = a.css("a")[0]["href"]
      url = "https://www.atlasobscura.com#{path}"
      RhodyAttractions::Attraction.new(name, town, short_description, url)
    end
    
    next_page = nokogiri_object.css(".next a")
    if !next_page.empty?
      self.site_url = "https://www.atlasobscura.com#{next_page[0]['href']}"
      make_page
    end
  end
end