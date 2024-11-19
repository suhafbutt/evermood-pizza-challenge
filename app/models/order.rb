# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items
  has_many :oder_offers
  has_many :promotions, through: :oder_offers
  has_many :discounts, through: :oder_offers
end
