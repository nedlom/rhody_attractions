class RhodyAttractions::CLI
  
  def greeting
    puts "", "Welcome to RhodyAttractions", ""
    RhodyAttractions::Scraper.new.make_page
    # binding.pry
    list_towns
    # list_places
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
  
  def list_towns
    RhodyAttractions::Attraction.towns.each.with_index(1) do |a, i|
      puts "#{i}. #{a}"
    end
    print "Enter a number: "
    x = gets.strip.to_i
    y = RhodyAttractions::Attraction.towns[x-1]
    RhodyAttractions::Attraction.attractions_by_town(y).each do |a|
      puts a.name
    end
  end
  
  def attraction_by_town(town)
     RhodyAttractions::Attraction.all.each do |a|
       if a.town == town
         puts a.name
       end
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
    short_summary(a)
  end
  
  def short_summary(x)
    puts "#{"-" * 20}#{x.name}#{"-" * 20}"
    puts "Location: #{x.town}"
    puts "Website: #{x.url}"
    print_description(x.short_description)
    
    puts ""
    print "Would you like more info: "
    a = gets.strip
    if a == "y"
      puts ""
      detailed_summary(x)
    end
  end
  
  def detailed_summary(x)
    puts "#{"-" * 20}#{x.name}#{"-" * 20}"
    puts "Location: #{x.street_address}, #{x.town}"
    puts "Website: #{x.url}"
    # puts "Short Description: #{x.short_description.strip}"
    print_description(x.long_description)
    places_nearby(x)
  end
  
  def print_description(description)
    puts ""
    puts "Description: "
    lines = description.split(/(.{1,50})(\s+|$)/)
    lines.delete_if {|l| l == " " || l == "" || l == "\n"}
    lines.each_with_index do |l, i|
      lines[i] = "\t" + lines[i]
    end
    lines.each do |l|
      puts l
    end
  end
  
  def places_nearby(x)
    puts ""
    puts "Attractions nearby:"
    y = x.places_nearby.map {|a| a.text.strip.split("\n")}
    y.each {|a| puts "\t#{a[0]} - #{a[1]} away"}
  end
end