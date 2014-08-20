require 'csv'
require 'pp'

# Set up hash:
csv = CSV.read('data/gschool_commute_data.csv', headers: true)
commutes = []
csv.each do |row|
  commutes.push(row.to_h)
end

by_person = commutes.group_by { |hash| hash['Person'] }

by_person.each_value do |values|
  values.each do |hashes|
    hashes.each do |key, value|
      if key == "Person"
        hashes.delete(key)
      end
    end
  end
end


# Nate's commute time:
by_person["Nate"].each do |hash|
  if hash["Week"] == "4" && hash["Day"] == "Wednesday"
    pp "Nate's time: #{hash["Inbound"]}"
  end
end


# Average commute times:
x = (by_person.values).flatten
  inbound = x.map{|time|time["Inbound"]}
  outbound = x.map{|time|time["Outbound"]}

inbound_sum = 0
inbound.each {|time|inbound_sum += time.to_i}


outbound_sum = 0
outbound.each {|time|outbound_sum += time.to_i}


puts "Average time inbound: #{inbound_sum/inbound.length}"

puts "Average time outbound: #{outbound_sum/outbound.length}"

puts "Average total: #{(inbound_sum + outbound_sum)/(inbound.length + outbound.length)}"


#Fastest walk time:
by_person.each do |person, array|
  array.delete_if do |hash|
    hash["Mode"] != "Walk"
  end
end

by_person.delete_if{|key, value| value == []}

by_person.each do |person, array|
  array.map!{|time|time["Inbound"].to_i + time["Outbound"].to_i}
end

emily = by_person["Emily"]
emily_sum = 0
emily.each{|time|emily_sum += time}


rachel = by_person["Rachel"]
rachel_sum = 0
rachel.each{|time|rachel_sum += time}

puts "Is Rachel faster than Emily?"
pp emily_sum > rachel_sum

puts "Emily's average time is: #{emily_sum/emily.count}"