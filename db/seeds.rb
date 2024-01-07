# frozen_string_literal: true

# ================== User create =======================
# okuyama
okuyama = User.create!(name: 'okuyama | HC', username: 'output0121', email: 'ooyy0121@gmail.com', password: '484848')

# sato
sato = User.create!(name: 'sato | HD', username: 'sato02', email: 'sato@example.com', password: '484848')

# yamada
yamada = User.create!(name: 'yamada', username: 'yamada03', email: 'yamada@example.com', password: '484848')

# suzuki
suzuki = User.create!(name: 'suzuki', username: 'suzuki04', email: 'suzuki@example.com', password: '484848')

# ========== tweet 作成 ===============

10.times do |n|
  variable_name = "okuyama_posts#{n}"
  okuyama_posts = okuyama.posts.create!(
    post_content: "okuyamaの#{n + 1}回目の投稿です"
  )
  instance_variable_set("@#{variable_name}", okuyama_posts)
end

10.times do |_n|
  okuyama.posts.create!(
    post_content: Faker::Lorem.paragraph(sentence_count: 3)
  )
end

10.times do |n|
  sato.posts.create!(post_content: "satoの#{n + 1}回目の投稿です")
end

10.times do |_n|
  sato.posts.create!(post_content: Faker::Lorem.paragraph(sentence_count: 3))
end

10.times do |n|
  yamada.posts.create!(post_content: "yamadaの#{n + 1}回目の投稿です")
end

10.times do |_n|
  yamada.posts.create!(post_content: Faker::Lorem.paragraph(sentence_count: 3))
end

10.times do |n|
  suzuki.posts.create!(post_content: "suzukiの#{n + 1}回目の投稿です")
end

10.times do |_n|
  suzuki.posts.create!(post_content: Faker::Lorem.paragraph(sentence_count: 3))
end
