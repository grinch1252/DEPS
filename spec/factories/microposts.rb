FactoryBot.define do
  factory :micropost do
    time { 1 }
    title { "MyString" }
    content { "MyText" }
    user { nil }
  end
end
