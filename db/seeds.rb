puts "🧑‍💻建立admin@admin.test為管理員中..."
email = 'admin@admin.test'
password = '123456'

admin = User.find_or_create_by(email: email) do |u|
  u.password = password
  u.password_confirmation = password
  u.role = 'admin'
end
