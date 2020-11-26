FactoryBot.define do
  factory :microposts, :class => Micropost do
    trait :post_1 do
      time { 240 }
      title { "Sed ut" }
      content { "Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium" }
      user_id { 1 }
      created_at { 30.minutes.ago }
    end

    trait :post_2 do
      time { 180 }
      title { "sit, amet" }
      content { "sit, amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam" }
      user_id { 1 }
      created_at { 1.year.ago }
    end

    trait :post_3 do
      time { 59 }
      title { "Quis autem" }
      content { "Quis autem vel eum iure reprehenderit" }
      user_id { 1 }
      created_at { 2.hours.ago }
    end

    trait :post_4 do
      time { 207 }
      title { "Writing" }
      content { "Writing a short test" }
      user_id { 1 }
      created_at { Time.zone.now }
    end
  end
end