User.create!(name:  "Example User",
  email: "example@deps.org",
  password:              "foobar",
  password_confirmation: "foobar",
  activated: true,
  picture: open("#{Rails.root}/db/fixtures/default.jpg"))

5.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@deps.org"
password = "password"
User.create!( name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              picture: open("#{Rails.root}/db/fixtures/default.jpg"))
end

users = User.order(:created_at).take(3)
20.times do
  title = Faker::Lorem.words(1)
  # time = Faker::Number.number(digits: 4)
  content = Faker::Lorem.sentence(6)
  users.each { |user| user.microposts.create!(title: title, content: content) }
end