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
    
  def list_attractions
    RhodyAttractions::Attraction.all.each.with_index(1) do |a, i|
      puts "#{i}. #{a.name} - #{a.town}"
      a.short_description.scan(/(.{1,50})(?:\s|$)/m).each do |b|
        puts "#{" " * i.to_s.length}  #{b[0].strip}"
      end
      puts ""
    end
    # x = gets.strip.to_i
    # a = RhodyAttractions::Attraction.find_by_index(x)
    # places_nearby(a)
  end
    
  def select_attraction
  end
  
  def places_nearby(x)
    y = x.places_nearby.map {|a| a.text.strip.split("\n")}
    y.each {|a| puts "#{a[0]} - #{a[1]}"}
  end
end