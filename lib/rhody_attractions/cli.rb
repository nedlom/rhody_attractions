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
    while true
      input = gets.strip.to_i
      attraction = RhodyAttractions::Attraction.find_by_index(input)
      header = "#{"-" * 18}#{attraction.name}#{"-" * 18}"
      puts header #max length is 77
      puts ""
      # binding.pry
      attraction.long_description.scan(/(.{1,#{header.length}})(?:\s|$)/m).each do |b|
          puts b[0].strip
      end
      
      if attraction.website_url
        puts ""
        puts "Website: #{attraction.website_url}" 
      end
      
      puts ""
      puts "Address: #{attraction.street_address}, #{attraction.town}"
      places_nearby(attraction)
      puts ""
      select_attraction
    end
  end
  
  def places_nearby(x)
    puts ""
    puts "Some places nearby:"
    y = x.places_nearby.map {|a| a.text.strip.split("\n")}
    y.each {|a| puts "\t#{a[0]} - #{a[1]}"}
  end
end