puts "🧑‍💻清除原有admin@admin.test資料中..."
#如果沒建立過可以先註解掉下一行
User.where(email: 'admin@admin.test').destroy_all

puts "🧑‍💻建立admin@admin.test為管理員中..."
email = 'admin@admin.test'
password = '123456'

admin = User.find_or_create_by(email: email) do |u|
  u.password = password
  u.password_confirmation = password
  u.role = 'admin'
end

if admin.save
  puts "🌟管理員：#{admin.email}，角色：#{admin.role} 建立成功！"
  puts admin
else
  puts "❌建立管理員失敗，錯誤訊息：#{admin.errors.full_messages.join(', ')}"
end

puts "🏡建立商家中..."
30.times do
  email = Faker::Internet.email
  role = 'vendor'
  user = User.find_or_create_by(email: email ) do |u|
    u.password = '123456'
    u.password_confirmation = '123456'
    u.role = role
  end

  if user.save
    puts "🏡商家：#{user.email}，角色：#{user.role} 建立成功！"
  else
    puts "❌建立商家失敗，錯誤訊息：#{user.errors.full_messages.join(', ')}"
  end

  cities = %w[
    基隆市 臺北市 新北市 桃園市 新竹市 新竹縣
    苗栗縣 臺中市 彰化縣 南投縣 雲林縣 嘉義市
    嘉義縣 臺南市 高雄市 屏東縣 臺東縣 花蓮縣
    澎湖縣 金門縣 連江縣
  ]

  districts = %w[
    中正區 大同區 中山區 松山區 大安區 萬華區
    信義區 士林區 北投區 內湖區 南港區 文山區
  ]

  unless user.shop.present?
    shop = Shop.new(
      user_id: user.id,
      title: Faker::Company.name,
      description: Faker::Lorem.paragraph,
      tel: "(0#{rand(1..9)})#{Faker::Number.number(digits: 4)}-#{Faker::Number.number(digits: 4)}",
      city: cities.sample,
      district: districts.sample,
      street: Faker::Address.street_address,
      contact: Faker::FunnyName.name,
      contactphone: '0123456789',
      status: 'open'
    )

    if shop.save
      puts "👑商品建立中..."
      5.times do
        product = Product.new(
        title: Faker::Commerce.product_name,
        service_min: rand(1..240),
        price: rand(100..5000),
        onsale: true,
        shop_id: shop.id
      )

      if product.save
        puts "👑商品：#{product.title} 已建立"
      else
        puts '❌商品建立失敗'
        puts "❌錯誤訊息：#{product.errors.full_messages.join(', ')}"
      end
    end

    else
      puts '❌店家建立失敗'
      puts "❌錯誤訊息：#{shop.errors.full_messages.join(', ')}"
    end
  else
    puts '該使用者已擁有店家'
  end
  puts '---------------'
end

puts '消費者建立中......'

30.times do
  email = Faker::Internet.email
  role = 'general'
  user = User.find_or_create_by(email: email ) do |u|
    u.password = '123456'
    u.role = role
  end

  if user.save
    puts "👼消費者：#{user.email}，角色：#{user.role} 建立成功！"
  else
    puts "❌建立消費者失敗，錯誤訊息：#{user.errors.full_messages.join(', ')}"
  end
end

# 建立 Demo 商家的方法

#刪除demo商家
vendor_emails = %w[demo01@vendor.test demo02@vendor.test demo03@vendor.test]
#如果沒建立過可以先註解掉下一行
User.where(email: vendor_emails).destroy_all

def create_vendor(email, password, shop_data, products_data, order_quantity)
  vendor = User.find_or_create_by(email: email) do |u|
    u.password = u.password_confirmation = password
    u.role = 'vendor'
  end

  if vendor.save
    puts "🌟Demo商家：#{vendor.email}，角色：#{vendor.role} 建立成功！"
    puts "-----------------------------"
    create_shop(vendor, shop_data, products_data)
  else
    puts "❌建立商家失敗，錯誤訊息：#{vendor.errors.full_messages.join(', ')}"
  end
end

def create_shop(vendor, shop_data, products_data)
  return if vendor.shop.present?

  shop = Shop.create(user_id: vendor.id, **shop_data)

  if shop.persisted?
    puts "👑商品建立中..."
    products_data.each do |product_data|
      product = Product.create(product_data.merge(onsale: true, shop_id: shop.id))
      print_product_status(product)
    end
  else
    puts '❌店家建立失敗'
    puts "❌錯誤訊息：#{shop.errors.full_messages.join(', ')}"
  end
end

def print_product_status(product)
  if product.persisted?
    puts "👑商品：#{product.title} 已建立"
  else
    puts '❌商品建立失敗'
    puts "❌錯誤訊息：#{product.errors.full_messages.join(', ')}"
  end
end

# 建立 Demo 商家和相關資料
create_vendor(
  'demo01@vendor.test', '123456',
  { title: 'Personal 髮型美甲沙龍', description: '...', tel: '02-6666-6666', city: '台北市', district: '大同區', street: '承德路一段44號', contact: Faker::FunnyName.name, contactphone: '0123456789', status: 'open' },
  [{ title: '人氣手部輕薄設計款60選1', service_min: 120, price: 689 }, { title: '深層洗髮+造型剪髮', service_min: 120, price: 588 }, { title: '女士足部深層保養護理', service_min: 120, price: 689 }],
  10
)

create_vendor(
  'demo02@vendor.test', '123456',
  { title: 'Personal 髮型美甲沙龍', description: '...', tel: '02-6666-6666', city: '台北市', district: '中山區', street: '中山北路二段36巷32號', contact: Faker::FunnyName.name, contactphone: '0123456789', status: 'open' },
  [{ title: '韓式髮根燙', service_min: 240, price: 1209 }, { title: '基礎護理 | 日本資生堂', service_min: 200, price: 989 }, { title: '剪+燙+護 | 日本資生堂', service_min: 120, price: 2860 }],
  10
)

create_vendor(
  'demo03@vendor.test', '123456',
  { title: 'Vis Hair Salon', description: '...', tel: '02-6666-6666', city: '台北市', district: '中山區', street: '中山北路二段36巷32號', contact: Faker::FunnyName.name, contactphone: '0123456789', status: 'open' },
  [{ title: '韓式髮根燙', service_min: 240, price: 1209 }, { title: '基礎護理 | 日本資生堂', service_min: 200, price: 989 }, { title: '剪+燙+護 | 日本資生堂', service_min: 120, price: 2860 }],
  10
)

#建立訂單中
puts '建立訂單中....'

30.times do

  user = User.order("RANDOM()").first
  shop = Shop.order("RANDOM()").first
  product = shop&.products&.order("RANDOM()")&.first

  if user && shop && product
  order = Order.new(
      booked_email: user.email,
      user_id: user.id,
      shop_id: shop.id,
      product_id: product.id,
      serial: Faker::Alphanumeric.alphanumeric(number: 20),
    )

      if order.save
        puts "📝訂單：#{order.serial} 已建立,🏡訂購店家:#{order.shop.title},產品:#{order.product.title}"
        puts "------------------------------"
      else
        puts '❌訂單建立失敗'
        puts "🔺錯誤訊息：#{order.errors.full_messages.join(', ')}"
      end
    else
      puts '❌找不到足夠的使用者、店家或產品。'
    end
  end
