FactoryBot.define do
  factory :user do
    name { "TestUser" }
    email { "testuser@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
