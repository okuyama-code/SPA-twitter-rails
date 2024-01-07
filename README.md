https://github.com/okuyama-code/SPA-twitter-rails/pull/2

## 現在のブランチ
notification

## よく使うコマンド

```
sudo chmod -R 777 /home/okuyama/spa-twitter-rails/
```

```
docker compose run --rm api bundle exec rubocop -A
```

通知
rails
いいね、フォロー、コメントがあったときに通知テーブルに通知を書き込む
通知一覧APIを実装する(/api/v1/notifications)
react
通知の一覧を表示できるようにする
ダイレクトメッセージ
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

