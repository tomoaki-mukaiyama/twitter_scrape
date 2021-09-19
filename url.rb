require 'csv'

#csvの範囲を指定
# 25..28
# 1001..1620
# 501..1000
0..1
def range
  0..938
end

def file
  "twit_url-2021_09_17-14:25.csv"
end
@url_array = []


CSV.read("./csv_files/" + file)[range].each do |account_info|
  @url_array << account_info[0]
end

# PIXIV FANBOX tag検索結果画面でURL取得
# var nodes = document.querySelectorAll(".sc-1k1puon-0.cxnjJE")
# arr = []
# nodes.forEach( node => 
#   arr.push(node.getAttribute("href"))
# )