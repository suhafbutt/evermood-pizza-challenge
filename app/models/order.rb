# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items
  has_many :order_offer
  has_many :promotions, through: :order_offer
  has_many :discounts, through: :order_offer

  before_create :set_uuid

  scope :open, -> { where(state: 'OPEN') }

  def amount
    ::Orders::AmountCalculator.new(self).total_amount
  end

  private

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
