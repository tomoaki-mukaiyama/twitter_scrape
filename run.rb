require "selenium-webdriver"
require "webdrivers"
require "byebug"
require 'benchmark'
# require "date"
# require "csv"

url = "https://twitter.com/enginer_ni_naru"
@arr = []
5.times do
    @arr << url
end

def benchmark(set, run)
    Benchmark.bm 5 do |r|
        r.report "実行時間:" do
            set
            run
        end
    end
end


def set_options
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36"
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    options.add_argument("--user-agent=#{ua}")
    options
end

def scrape(options)
    driver = Selenium::WebDriver.for(:chrome, options: options)
    @arr.each do |url|
        driver.get(url)
        wait = Selenium::WebDriver::Wait.new(timeout: 60)

        # ターゲット要素設定
        follow_xpath = '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[5]/div[1]/a/span[1]/span'
        follower_xpath = '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[5]/div[2]/a/span[1]/span'

        # 読み込むまで待機
        wait.until { !driver.find_elements(:xpath, follow_xpath).empty? }

        #取得
        follow = driver.find_element(:xpath, follow_xpath)
        follower = driver.find_element(:xpath, follower_xpath)

        # 配列に代入
        info_array = [follow, follower]

        # 出力
        info_array.each do |a|
            p a.text
        end
    end
end
# def scrape(options)
#     driver = Selenium::WebDriver.for(:chrome, options: options)
#     @arr.each do |url|
#         driver.get(url)
#         wait = Selenium::WebDriver::Wait.new(timeout: 60)
#         wait.until { !driver.find_elements(:xpath, '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[5]/div[1]/a/span[1]/span').empty? }
#         follow = driver.find_element(:xpath, '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[5]/div[1]/a/span[1]/span')
#         follower = driver.find_element(:xpath, '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[5]/div[2]/a/span[1]/span')
#         info_array = [follow, follower]
#         info_array.each do |a|
#             p a.text
#         end
#     end
# end
    
benchmark(set_options, scrape(set_options))


# info_array = []
# File.open("#{DateTime.now.strftime("%Y%m%d%H%M%S")}.csv", "w") do |file|
#     info_array.each do |row| 
#        file.puts(row.to_csv) 
#     end
#  end