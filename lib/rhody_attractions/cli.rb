class RhodyAttractions::CLI
  
  def start
    greeting
    list_attractions
    select_attraction
  end
    
  def greeting
    puts "Howdy!"
    RhodyAttractions::Scraper.new.make_page
    binding.pry
  end
    
  #41 is length of longest name
  #40 is it's index
  
  def list_attractions
    RhodyAttractions::Attraction.all.each do |attraction|
      attraction.print_description("short")
      puts ""
    end
  end
  
  def select_attraction
    print "Select an attraction: "
    input = gets.strip.to_i
    attraction = RhodyAttractions::Attraction.find_by_index(input)
    format_attraction(attraction)
  end
    
  def format_attraction(attraction)
    puts ""
    attraction.print_description("long")
    if attraction.website_url
      puts ""
      puts "Website: #{attraction.website_url}" 
    end
    
    puts ""
    puts "Address: #{attraction.street_address}, #{attraction.town}"
    
    if attraction.know_before_you_go
      puts ""
      puts "Know Before You Go: #{attraction.know_before_you_go}"
    end
    places_nearby(attraction)
    puts ""
  end
  
  def places_nearby(x)
    puts ""
    puts "Some places nearby:"
    x.places_nearby.each.with_index(1) do |a, i|
      puts "\t #{i}. #{a.name}"
    end
    puts ""
    print "Would you like to see one of these? (y/n): "
    a = gets.strip
    if a == "y"
      print "Enter number: "
      b = gets.strip.to_i - 1
      format_attraction(x.places_nearby[b])
    end
    last_function
  end
  
  def last_function
    puts ""
    print "Would you like to a different attraction? (y/n): "
    x = gets.strip
    if x == "y"
      select_attraction
    else
      puts "Goodbye."
    end
  end
  
end