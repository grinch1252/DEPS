User.create!(:name => "Алексей Пажитнов",
  :email => "example@deps.org",
  :password => "foobar",
  :password_confirmation => "foobar",
  :activated => true,
  :picture => open("#{Rails.root}/db/fixtures/default.jpg"))

User.create!(:name => "Guest User",
  :email => "guest@deps.org",
  :password => "password",
  :password_confirmation => "password",
  :activated => true,
  :picture => open("#{Rails.root}/db/fixtures/default.jpg"))

50.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@deps.org"
password = "password"
User.create!( :name => name,
              :email => email,
              :password => password,
              :password_confirmation => password,
              :activated => true,
              :picture => open("#{Rails.root}/db/fixtures/no-icon.png"))
end

users = User.order(:created_at).take(10)
20.times do
  title = Faker::Lorem.words(1)
  # time = Faker::Number.number(3)
  content = Faker::Lorem.sentence(6)
  users.each { |user| user.microposts.create!(:title => title, :content => content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }