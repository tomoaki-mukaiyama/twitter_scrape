require "nokogiri"
require "httparty"
require "byebug"
require "csv"

def scraper
    url = ""
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    condos = parsed_page.css("div.cassetteitem") #全物件
    doc_csv = []
    
    page = 1
    
    while page <= 
        
        pagination_url = "#{page}"
        pagination_unparsed_page = HTTParty.get(pagination_url)
        pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page)
        pagination_condos = pagination_parsed_page.css("div.cassetteitem")
        pagination_condos.each do|condo|
            title = condo.css("div.cassetteitem_content-title").text
            condo_info = condo.css("li.cassetteitem_detail-col3").text.split
            years = condo_info[0]
            height = condo_info[1]
            rooms = condo.css("tr.js-cassette_link")
    
            rooms.each do |room|
                floor = room.css("td:contains('階')").text.split[0]
                price = room.css("span.cassetteitem_other-emphasis").text
                madori = room.css("span.cassetteitem_madori").text
                size = room.css("span.cassetteitem_menseki").text
                
                doc_csv << [title, years, height, floor, price, madori, size]
            end
        end
        page += 1
    end
        byebug
    
        File.open("condo.csv", "w") do |file|
       
       doc_csv.each do |row| 
          file.puts(row.to_csv) 
       end
    end

end

scraper