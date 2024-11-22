# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    association :order
    association :pizza
    association :pizza_size
  end
end
