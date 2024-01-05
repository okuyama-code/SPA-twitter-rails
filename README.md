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

リツイート
rails
リツイートAPIを実装する(/api/v1/tweets/:tweet_id/retweets)
ツイート一覧APIを拡張して、各ツイートのリツイート数を返すようにする
react
ツイート一覧画面からリツイートボタンを押してリツイートできるようにする
リツイート数を表示する
いいね
rails
いいねAPIを実装する(/api/v1/tweets/:tweet_id/favorites)
ツイート一覧APIを拡張していいね数を返すようにする
react
ツイート一覧画面からいいねボタンを押していいねできるようにする
いいね数を表示する

## コマンド
rails g model Repost user:references post:references
rails g controller reposts create destroy

rails g model Like user:references post:references
rails g controller likes create destroy
