## 現在のブランチ
comments

## よく使うコマンド

```
sudo chmod -R 777 /home/okuyama/spa-twitter-rails/
```

```
docker compose run --rm api bundle exec rubocop -A
```


## コメント機能　create destroy ツイート詳細画面での一覧 プロフィール画面で自分のコメント一覧を表示する(users#showに記載)

ツイートのコメントAPIを実装する(/api/v1/comments)
react
ツイート一覧画面からコメントをできるようにする
コメントは本家twitter同様モーダルで実装する
コメント一覧機能
rails
コメント一覧APIを実装する(/api/v1/tweets/:tweet_id/comments)
react
ツイートを押すとツイート詳細画面に遷移し、該当ツイートとコメント一覧を表示する
rails(コメント削除API)
コメントの削除機能を実装する(/api/v1/comments/${id})
react(コメント一覧画面)
プロフィール画面で自分のコメント一覧を表示する
削除もできるようにすること
