#  twitterスクレイピング
# １万件のtwitterプロフィールから以下の情報を取得する  
 ・ページでdm解放か否か  
 ・フォロー  
 ・フォロワー  
 ・最新のツイートの日付(固定ツイートは除く)  

# 大量のURLを捌く問題
参照　https://nishinatoshiharu.com/rails-treat-huge-csv/
分割してメモリ負担を減らす

# DM可否はログイン必須問題
seleniumにクッキー情報を渡してログイン状態を作る  

# スクレイピング処理（urlを受け取り、csvを生成）
空の配列 info_array 定義  
url100件配列 ループ
urlを渡す  
アクセスする  
ページごとに取得した情報を配列にセットし,@info_arrayに入れる(ネスト配列)  
@info_array << [follow, follower, latest_tweet, dm]  

# csv出力
最後にまとめてcsv書き込み  
./csv_filesディレクトリでまとめて、gitignore
