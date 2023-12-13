puts "建立資料中..."

5.times do
  email = Faker::Internet.email

  user = User.find_or_create_by(email:) do |u|
    u.password = '123456'
  end

  puts "使用者：#{user.email}"
end

puts "資料建立完成"
