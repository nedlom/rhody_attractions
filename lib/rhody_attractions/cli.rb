class RhodyAttractions::CLI
    
  def start
    puts "Howdy!\n\n"
    RhodyAttractions::Scraper.new.make_page
    puts "Printing list\n\n"
    sleep(2)
    list_attractions
    select_attraction
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
      puts "\nWebsite: #{attraction.website_url}" 
    end
    
    puts "\nAddress: #{attraction.street_address}, #{attraction.town}"
    
    if attraction.know_before_you_go
      puts "\nKnow Before You Go: "
      attraction.know_before_you_go.scan(/(.{1,60})(?:\s|$)/m).each do |b|
        puts b[0].strip
      end
    end
    
    places_nearby(attraction)
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
      print "\n Ok. Please enter number: "
      b = gets.strip.to_i - 1
      format_attraction(x.places_nearby[b])
    else
      last_function
    end
  end
  
  def last_function
    print "\nWould you like to a different attraction? (y/n): "
    x = gets.strip
    if x == "y"
      puts ""
      puts "Printing list\n\n"
      sleep(2)
      list_attractions
      select_attraction
    else
      puts "\nBuh-bye now!\n\n"
    end
  end
  
  def valid_input1?
    
  end
  
  def validate_input2?
  end
  
end