require "selenium-webdriver"
require "webdrivers"
require "httparty"
require "byebug"
require "csv"

ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36"

url = "https://twitter.com/enginer_ni_naru"
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')
options.add_argument('--disable-gpu')
options.add_argument("--user-agent=#{ua}")

driver = Selenium::WebDriver.for(:chrome, options: options)
driver.get(url)
# byebug

p "アクセスされた-----------------------"
wait = Selenium::WebDriver::Wait.new(timeout: 60)

wait.until { !driver.find_elements(:css, ".css-4rbku5.css-18t94o4.css-901oao.r-18jsvk2.r-1loqt21.r-1tl8opc.r-a023e6.r-16dba41.r-rjixqe.r-bcqeeo.r-qvutc0").empty? }
follow = driver.find_elements(:css, ".css-4rbku5.css-18t94o4.css-901oao.r-18jsvk2.r-1loqt21.r-1tl8opc.r-a023e6.r-16dba41.r-rjixqe.r-bcqeeo.r-qvutc0")

follow.each do |a|
    p a.text
end