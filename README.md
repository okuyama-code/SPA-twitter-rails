## setup
docker compose build
docker compose run --rm web bin/setup
docker compose run --rm web yarn install

## run
docker compose up
docker compose exec web bash
rails db:create
rails db:migrate
rails db:seed
http://localhost:3000

## よく使うコマンド

```
sudo chmod -R 777 /home/okuyama/spa-twitter-rails/
```

```
docker compose run --rm api bundle exec rubocop -A
```

