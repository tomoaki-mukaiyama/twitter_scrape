require "selenium-webdriver"
require "httparty"
require "byebug"
require 'benchmark'
require "./url"

# require "date"
# require "csv"

def set_options
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36"
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument("--user-agent=#{ua}")
    options
end

def scrape(options)
    @info_array = []
    
    @url_array.each do |url|
        driver = Selenium::WebDriver.for(:chrome, options: options)
        driver.get(url)
        xpath = '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[2]/div/div/div[1]/div/span[1]/span'
        follow_xpath = '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[5]/div[1]/a/span[1]/span'
        follower_xpath = '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[5]/div[2]/a/span[1]/span'
        wait = Selenium::WebDriver::Wait.new(timeout: 60)
        wait.until { !driver.find_elements(:xpath, follow_xpath).empty? }
        wait.until { !driver.find_elements(:xpath, xpath).empty? }
        
        
        account_user = driver.find_element(:xpath, xpath)
        follow = driver.find_element(:xpath, follow_xpath)
        follower = driver.find_element(:xpath, follower_xpath)
        
        @info_array << [account_user, follow, follower]
        
        # byebug          
    end
end

scrape(set_options)

@info_array.each do |array|
    array.each do |account_info|
        p account_info.text
    end
end

# ターゲット要素設定
# 読み込むまで待機
# 取得
# 配列に代入
# 出力
# info_array.each do |a|
#     p a.text
# end


# info_array = []
# File.open("#{DateTime.now.strftime("%Y%m%d%H%M%S")}.csv", "w") do |file|
#     info_array.each do |row| 
#        file.puts(row.to_csv) 
#     end
#  end

# def benchmark(set, run)
#     Benchmark.bm 5 do |r|
#         r.report "実行時間:" do
#             set
#             run
#         end
#     end
# end
# benchmark(set_options, scrape(set_options))
