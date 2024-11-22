# frozen_string_literal: true

class Offer < ApplicationRecord
  has_many :orders, through: :order_offers
end
