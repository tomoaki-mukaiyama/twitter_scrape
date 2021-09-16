require 'csv'

#csvの範囲を指定
25..28
1..3
def range
  1001..1620
end

@url_array = []

CSV.read("./csv_files/url_list.csv")[range].each do |account_info|
  @url_array << account_info[4]
end