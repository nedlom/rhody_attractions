class RhodyAttractions::CLI
  
  def start
    greeting
    RhodyAttractions::Scraper.new.make_page
    list_attractions
    select_attraction
  end
    
  def greeting
    puts "Howdy!"
  end
    
  #41 is length of longest name
  #40 is it's index
  def list_attractions
    RhodyAttractions::Attraction.all.each.with_index(1) do |a, i|
      puts "#{i}. #{a.name} - #{a.town}"
      a.short_description.scan(/(.{1,50})(?:\s|$)/m).each do |b|
        puts "#{" " * i.to_s.length}  #{b[0].strip}"
      end
      puts ""
    end
  end
    
  def select_attraction
    x = gets.strip.to_i
    a = RhodyAttractions::Attraction.find_by_index(x)
    puts "#{"-" * 18}#{a.name}#{"-" * 18}" #max length is 77
    puts "#{a.street_address}, #{a.town}"
    puts a.website_url if a.website_url
    puts ""
    a.long_description.scan(/(.{1,77})(?:\s|$)/m).each do |b|
        puts b[0].strip
      end
    places_nearby(a)
  end
  
  def places_nearby(x)
    puts ""
    puts "Some places nearby:"
    y = x.places_nearby.map {|a| a.text.strip.split("\n")}
    y.each {|a| puts "\t#{a[0]} - #{a[1]}"}
  end
end