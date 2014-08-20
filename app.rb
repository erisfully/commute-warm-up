require 'csv'
require 'pp'


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

by_person["Nate"].each do |hash|
  if hash["Week"] == "4" && hash["Day"] == "Wednesday"
    pp "Nate's time: #{hash["Inbound"]}"
  end
end


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





