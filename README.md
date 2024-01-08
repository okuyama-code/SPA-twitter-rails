## 現在のブランチ
dm

## よく使うコマンド

```
sudo chmod -R 777 /home/okuyama/spa-twitter-rails/
```

```
docker compose run --rm api bundle exec rubocop -A
```

## 参考URL
https://qiita.com/aaaasahi_17/items/9e7f344488c720aaf116

https://github.com/okuyama-code/hc_twitter_clone/blob/notification/app/controllers/users_controller.rb

https://github.com/okuyama-code/hc_twitter_clone/blob/notification/app/controllers/rooms_controller.rb

https://github.com/okuyama-code/hc_twitter_clone/blob/notification/app/controllers/messages_controller.rb

rails
グループ作成APIを実装する(/api/v1/groups)
グループでメッセージを投稿できるようにする(/api/v1/groups/:group_id/messages)
グループ内のメッセージを参照できるようにメッセージ一覧APIを実装する(/api/v1/:group_id/messages)
グループの一覧を参照できるAPIを実装する(/api/v1/groups)
react
サイドバーからメッセージ画面に遷移できるようにする
遷移後はグループ一覧画面に遷移する
任意のグループを選択するとグループ詳細画面が表示され、メッセージの表示、投稿ができるようにする


ブックマーク
rails
ブックマークAPIを実装する(/api/v1/bookmarks)
ブックマーク一覧APIを実装する(/api/v1/bookmarks)
react
ツイート一覧画面からツイートをブックマークできるようにする
退会
rails
退会のAPIが動作することを確認する
react
本家twitterは「もっと見る」=>「設定とサポート」から退会ができるようになっているが、今回はサイドバーに退会ボタンを表示して退会できるようにする

