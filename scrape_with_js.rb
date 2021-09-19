require "selenium-webdriver"
require "webdrivers"
require "byebug"

ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36"
capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions" => {
        "args" => [
            "--user-agent=#{ua}",
        ]
    }
)

driver = Selenium::WebDriver.for(:chrome, desired_capabilities: capabilities)
# url = "https://www.goo-net.com/usedcar/brand-TOYOTA/"
url = "https://www.goo-net.com/usedcar/brand-top.html#brand_top"
driver.get(url)
driver.manage.timeouts.implicit_wait = 5
info_array = driver.execute_script('''
  var nodes = document.querySelector("#brand_top").querySelectorAll("ul > li");
  arr = [];
  nodes.forEach( node =>
    arr.push(node.querySelector("a").href)
  )
  return arr;
  ''')
info_array.each do |url|
  sleep 1
  driver.get(url)
  driver.manage.timeouts.implicit_wait = 5
  info_array = driver.execute_script('''
    var nodes = document.querySelectorAll(".car_name");
    arr = [];
    nodes.forEach(node =>
      arr.push([node.querySelector("a").innerText, node.querySelector("span").innerText.split("(")[1].split(")")[0]])
    )
    return arr;
    ''')
    p info_array.sort_by{|x| x[1].to_i}.first
  end
