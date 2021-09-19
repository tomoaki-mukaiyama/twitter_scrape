require "nokogiri"
require "httparty"
require 'byebug'
require 'csv'
require './csv_files/pixiv_url.rb'

# 最終的にtwitterURLの配列を入れてcsvに書き出し、
# それをrun.rbでインポートする
  @url_array = [] 
  

  @fanbox_url_array.each_with_index do |url, index|

    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    parsed_page.css()
    


    
    
    # 現在何件目かをコンソールに出力
    p (index + 1).to_s + "件目"
    sleep 1
    # current_url = driver.current_url
    

    # @url_array << [current_url,]



    
  end

  # ./csv_files/twit_data-(日時).csv で新規保存
CSV.open("./csv_files/twit_data-#{DateTime.now.strftime("%Y_%m_%d-%H:%M")}.csv", "w") do |csv|
  p "csv書き出し中"
  @url_array.each do |array|
      csv << array
  end
end 