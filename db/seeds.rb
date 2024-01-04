puts "建立管理員中..."
email = 'admin@admin.test'
admin = User.find_or_create_by(email: email) do |u|
  u.password = '123456'
  u.password_confirmation = '123456'
  u.role = 'admin'
end

if admin.save
  puts "管理員：#{admin.email}，角色：#{admin.role} 建立成功！"
else
  puts "建立管理員失敗，錯誤訊息：#{admin.errors.full_messages.join(', ')}"
end




puts "建立商家中..."
10.times do
  email = Faker::Internet.email
  role = 'vendor'
  user = User.find_or_create_by(email: email ) do |u|
    u.password = '123456'
    u.role = role
  end

  if user.save
    puts "商家：#{user.email}，角色：#{user.role} 建立成功！"
  else
    puts "建立商家失敗，錯誤訊息：#{user.errors.full_messages.join(', ')}"
  end

  counties = %w[
    基隆市 臺北市 新北市 桃園市 新竹市 新竹縣
    苗栗縣 臺中市 彰化縣 南投縣 雲林縣 嘉義市
    嘉義縣 臺南市 高雄市 屏東縣 臺東縣 花蓮縣
    澎湖縣 金門縣 連江縣
  ]

  unless user.shop.present?
    shop = Shop.new(
      user_id: user.id,
      title: Faker::Company.name,
      description: Faker::Lorem.paragraph,
      tel: "(0#{rand(1..9)})#{Faker::Number.number(digits: 4)}-#{Faker::Number.number(digits: 4)}",
      city: '台北市',
      district: '中正區',
      street: "衡陽路#{rand(1..500)}巷#{rand(1..50)}號",
      contact: Faker::FunnyName.name,
      contactphone: Faker::PhoneNumber.cell_phone,
      status: 'open'
    )

    cover_image = Faker::Company.logo

    shop.cover.attach(
      io: File.open(cover_image),
      filename: "#{shop.title.parameterize}_cover.jpg",
      content_type: 'image/jpeg'
    )

    if shop.save
      puts "店家：#{shop.title} 已建立"
    else
      puts '店家建立失敗'
      puts "錯誤訊息：#{shop.errors.full_messages.join(', ')}"
    end
  else
    puts '該使用者已擁有店家'
  end
end
