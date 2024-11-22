# frozen_string_literal: true

FactoryBot.define do
  factory :pizza_size do
    name { 'Small' }
    multiplier { 0.7 }
  end
end
