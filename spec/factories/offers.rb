# frozen_string_literal: true

FactoryBot.define do
  factory :offer do
    trait :discount do
      type { 'Discount' }
      code { 'SAVE5' }
      discount { 5 }
    end

    trait :promotion do
      code { '2FOR1' }
      type { 'Promotion' }
      discount { 50 }
      target { 'Salami' }
      target_size { 'Small' }
      from { 2 }
      to { 1 }
    end
  end
end
