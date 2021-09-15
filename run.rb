require "selenium-webdriver"
require "webdrivers"
require "byebug"
require "./url"
require "csv"
require "date"

def set_options
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36"
    user_profile_path = "/Users/tomoakimukaiyama/Library/Application Support/Google/Chrome/Default"
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        "goog:chromeOptions" => {
            "args" => [
                "--user-agent=#{ua}",
                "--user-data-dir=#{user_profile_path}"
            ]
        }
    )
    
    capabilities #return
end

def scrape(options)
    
    driver = Selenium::WebDriver.for(:chrome, desired_capabilities: options)
    
    @url_array.each_with_index do |url, index|
        driver.get(url)
        driver.manage.timeouts.implicit_wait = 5
        
        #  DMアイコン, フォロー数, フォロワー数, ユーザ名　のセレクタ
        dm_button_selector = '[data-testid="sendDMFromProfile"]'
        follow_xpath = '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[5]/div[1]/a/span[1]/span'
        follower_xpath = '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[5]/div[2]/a/span[1]/span'
        username_xpath = '//*[@id="react-root"]/div/div/div[2]/main/div/div/div/div[1]/div/div[2]/div/div/div[1]/div/div[2]/div/div/div[1]/div/span[1]/span'
        
        # DM解放判別
        if (driver.find_elements(:css, dm_button_selector).size >= 1)
            dm_button = "true"
        else
            dm_button = "false"
        end
        
        # フォロー数, フォロワー数, ユーザ名, 現在のURL
        follow = driver.find_element(:xpath, follow_xpath).text
        follower = driver.find_element(:xpath, follower_xpath).text
        account_username = driver.find_element(:xpath, username_xpath).text
        current_url = driver.current_url
        
        @info_array << [dm_button, follow, follower, account_username, current_url]
        
        # 進捗
        p (index + 1).to_s + "件目"
        p "1スリープ"
        sleep 1
        p "2スリープ"
        sleep 1
        p "再開"

        rescue Selenium::WebDriver::Error::NoSuchElementError
        p 'No Such Element Error'

    end
end

@info_array = [["DM" ,"follow","follower","name"]]

scrape(set_options)

# ./csv_files/twit_data-(日時).csv で新規保存
CSV.open("./csv_files/twit_data-#{DateTime.now.strftime("%Y_%m_%d-%H:%M")}.csv", "w") do |csv|
    p "csv書き出し中"
    @info_array.each do |array|
        csv << array
    end
end 
