require 'csv'

CSV.foreach('data/gschool_commute_data.csv') do |row|
  p row.inspect
end
