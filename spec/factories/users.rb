FactoryBot.define do

  factory :user do
    name { "TestUser" }
    email { "testuser@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :other_user, class: User do
    name { "OtherUser" }
    email { "otheruser@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end
