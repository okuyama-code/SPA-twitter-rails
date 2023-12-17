okuyama = User.create!(name: "okuyama | HC", username: "output0121", email: "ooyy0121@gmail.com", password: "484848")

sato = User.create!(name: "sato | HD", username: "sato02", email: "sato@example.com", password: "484848")

yamada = User.create!(name: "yamada", username: "yamada03", email: "yamada@example.com", password: "484848")
suzuki = User.create!(name: "suzuki", username: "suzuki04", email: "suzuki@example.com", password: "484848")


# ========== tweet 作成 ===============

10.times do |n|
  okuyama_tweets = okuyama.tweets.create!(tweet_content: "okuyamaの#{n + 1}回目の投稿です")
end

10.times do |n|
  sato_tweets = sato.tweets.create!(tweet_content: "satoの#{n + 1}回目の投稿です")
end

10.times do |n|
  yamada_tweets = yamada.tweets.create!(tweet_content: "yamadaの#{n + 1}回目の投稿です")
end

10.times do |n|
  suzuki_tweets = suzuki.tweets.create!(tweet_content: "suzukiの#{n + 1}回目の投稿です")
end
