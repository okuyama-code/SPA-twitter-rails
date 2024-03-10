## setup
docker compose build
docker compose run --rm api bin/setup

## run
docker compose up
docker compose exec api bash
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

