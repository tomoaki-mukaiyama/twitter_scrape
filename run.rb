require "selenium-webdriver"
require "httparty"
require "byebug"
require "csv"

options = Selenium::WebDriver::Chrome::Options.new
# headlessモード
options.add_argument('--headless')
options.add_argument('--disable-gpu')
options.add_argument("--user-agent=#{ua}")

driver = Selenium::WebDriver.for(:chrome, options: options)
driver.get('https://www.amazon.co.jp/gp/offer-listing/B07HC2F97Q/ref=dp_olp_new?ie=UTF8&condition=new')

# PROFILE_PATH
url = "https://twitter.com/makaibito"
