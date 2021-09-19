require "selenium-webdriver"
require "webdrivers"
require "byebug"
require "csv"
require "date"


def set_options
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36"
    user_profile_path = "/Users/tomoakimukaiyama/Library/Application Support/Google/Chrome/Default"
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        "goog:chromeOptions" => {
            "args" => [
                "--user-agent=#{ua}",
            ]
        }
    )
    
    capabilities #return
end

def get_url(options)
  driver = Selenium::WebDriver.for(:chrome, desired_capabilities: options)
  url_array = []

  while true do
    page_num = 1
    sleep 1
    driver.manage.timeouts.implicit_wait = 3
    url = "https://0000.studio/commission-list?page=#{page_num}"
    driver.get(url)

    20.times do |path_num|
      url_array << driver.find_element(:xpath, "//*[@id='__layout']/div/div[4]/div[2]/div/div/section[2]/div[#{path_num + 1}]/div/a").attribute("href")
      rescue Selenium::WebDriver::Error::NoSuchElementError
        p 'No Such Element Error'
        page_num = -1
        break
    end

    if page_num == -1
      break
    end

    page_num ++
  end

  @twitter_urls = []
  url_array.each do |url|
    sleep 1
    driver.get(url)
    sns_bar = driver.find_element(:xpath, '//*[@id="__layout"]/div/div[4]/div[2]/main/div[3]/section[1]/div[3]/div[1]/div[1]')
    sns_icons = sns_bar.find_elements(:tag_name,'a')
    if sns_icons > 0
      sns_bar.find_elements(:tag_name,'a').each do |icon|
        if icon.attribute("href").include?("twitter")
          @twitter_urls << icon.attribute("href")
        each_with_index 
      end 
    end
    # rescue Selenium::WebDriver::Error::NoSuchElementError
    # p 'No Such Element Error'
  end
end
  
get_url(set_options)

# # ./csv_files/twit_data-(日時).csv で新規保存
CSV.open("./csv_files/twitter-urls-#{DateTime.now.strftime("%Y_%m_%d-%H:%M")}.csv", "w") do |csv|
    p "csv書き出し中"
    @twitter_urls.each do |array|
        csv << array
    end
end 
