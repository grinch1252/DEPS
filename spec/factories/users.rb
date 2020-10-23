FactoryBot.define do

  factory :user, class: User do
    name { "TestUser" }
    email { "testuser@example.com" }
    password { "password" }
    password_confirmation { "password" }
    activated { true }
  end

  factory :other_user, class: User do
    name { "OtherUser" }
    email { "otheruser@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    activated { true }
  end

  factory :no_activated_user, class: User do
    name { "NoActivatedUser" }
    email { "NoActuser@example.com" }
    password { "bazfor" }
    password_confirmation { "bazfor" }
    activated { false }
  end
end
