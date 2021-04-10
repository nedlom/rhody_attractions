class RhodyAttractions::CLI
  
  def greeting
    puts "", "Welcome to RhodyAttractions", ""
    # sleep 0.5
    # this
    RhodyAttractions::Scraper.new.make_page
    list_places
  end
  
  def this
    3.times do 
      x = "loading attractions."
      y = x.length
      while x.length < y + 3
        print "\r#{x}"
        sleep 0.5
        print "\r#{" " * x.length}"
        sleep 0.5
        x = x + "."
      end
    end
  end
  
  def loading
    3.times do
      print "\rloading."
      sleep 0.5
      print "\r        "
      sleep 0.5
      print "\rloading.."
      sleep 0.5
      print "\r         "
      sleep 0.5
      print "\rloading..."
      sleep 0.5
      print "\r          "
      sleep 0.5
    end
  end
    
  def list_places
    RhodyAttractions::Attraction.all.each.with_index(1) do |a, i|
      puts "#{i}. #{a.name}"
    end
    select_attraction
  end
    
  def select_attraction
    puts "select attraction: "
    a_index = gets.strip.to_i
    a = RhodyAttractions::Attraction.find_by_index(a_index)
    more_info(a)
  end
  
  def more_info(x)
    puts x.name
    puts x.short_description.strip
    puts x.town
    puts x.url
    places_nearby(x)
  end
  
  def places_nearby(x)
    y = x.places_nearby.map {|a| a.text.strip.split("\n")}
    y.each {|a| puts "#{a[0]} - #{a[1]}"}
  end
end