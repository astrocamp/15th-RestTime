puts "建立資料中..."

5.times do
  email = Faker::Internet.email

  user = User.find_or_create_by(email:) do |u|
    u.password = '123456'
  end

  puts "使用者：#{user.email}"

  def generate_phone_number
    "(02)#{format('%02d', rand(0..99))}-#{Faker::Number.number(digits: 6)}"
  end

  10.times do
    product = user.shop.create(
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph,
      tel: generate_phone_number(),
      city: '台北市',
      district: '中正區',
      street: '衡陽路499號2344巷27樓'
    )

    puts "建立商品：#{product.title}"
  end
end

puts "資料建立完成"
