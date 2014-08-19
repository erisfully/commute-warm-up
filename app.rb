require 'csv'
require 'pp'

CSV.foreach('data/gschool_commute_data.csv', headers: true) do |row|
  hashes = row.to_h
  pp hashes
end










