https://github.com/okuyama-code/SPA-twitter-rails/pull/2

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


コメント一覧機能

rails(コメント削除API)
コメントの削除機能を実装する(/api/v1/comments/${id})
react(コメント一覧画面)
プロフィール画面で自分のコメント一覧を表示する
削除もできるようにすること
