require 'csv'
require 'pp'


csv = CSV.read('data/gschool_commute_data.csv', headers: true)
commutes = []
csv.each do |row|
  commutes.push(row.to_h)
end

by_person = commutes.group_by{|hash| hash['Person']}

by_person.each_value do |values|
  values.each do |hashes|
    hashes.each do |key, value|
      if key == "Person"
        hashes.delete(key)
      end
    end
  end
end

by_person["Nate"].each do |week|
  if week["Week"] == "4" && week["Day"] == "Wednesday"
    pp week["Inbound"]
  end
end








