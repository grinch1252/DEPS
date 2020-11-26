FactoryBot.define do
  factory :events, :class => Event do
    trait :event_1 do
      title { "Sed ut" }
      body { "Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium" }
      user_id { 1 }
      start { Time.zone.now.since(10.minutes) }
      created_at { 30.minutes.ago }
    end

    trait :event_2 do
      title { "sit, amet" }
      body { "sit, amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt, ut labore et dolore magnam aliquam" }
      user_id { 1 }
      start { Time.zone.now.since(30.minutes) }
      created_at { 1.year.ago }
    end

    trait :event_3 do
      title { "Quis autem" }
      body { "Quis autem vel eum iure reprehenderit" }
      user_id { 1 }
      start { Time.zone.now.since(3.years) }
      created_at { 2.hours.ago }
    end

    trait :event_4 do
      title { "Writing" }
      body { "Writing a short test" }
      user_id { 1 }
      created_at { Time.zone.now }
      start { Time.zone.now }
    end
    # association :user, factory: :user
  end
end
