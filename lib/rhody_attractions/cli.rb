class RhodyAttractions::CLI
  
  def greeting
    puts "Getting rhody attractions"
    RhodyAttractions::Scraper.new.make_page
    list_places
  end
    
  def list_places
    RhodyAttractions::Attraction.all.each.with_index(1) do |a, i|
      puts "#{i}. #{a.name}"
    end
    pick_a_place
  end
  
  def pick_a_place
    puts ""
    print "Pick a place: "
    x = gets.strip.to_i
    puts ""
    a = RhodyAttractions::Attraction.find_by_index(x)
    places_nearby(a)
  end
    
  def function(x)
  end
  
  def places_nearby(x)
    puts "Three closest attractions:"
    y = x.places_nearby.map {|a| a.text.strip.split("\n")}
    y.each.with_index(1) do |a, i|
      puts "#{i}. #{a[0]} - #{a[1]} from #{x.name}"
    end
    pick_a_place
  end
end