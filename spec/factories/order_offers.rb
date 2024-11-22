# frozen_string_literal: true

FactoryBot.define do
  factory :order_offer do
    association :order
  end
end
