# frozen_string_literal: true

module Orders
  class AmountCalculator
    attr_reader :order, :order_items

    def initialize(order)
      @order = order
      @order_items = order.order_items.includes(:pizza, :pizza_size)
    end

    def total_amount
      base_amount = calculate_base_amount
      promo_amount = calculate_promotion_amount
      discounted_amount = apply_discounts(base_amount - promo_amount)
      discounted_amount.round(2)
    end

    private

    def calculate_base_amount
      order_items.sum(&:amount)
    end

    def calculate_promotion_amount
      total_promo_amount = 0
      order.promotions.each do |promotion|
        promotion_items = fetch_promotion_items(promotion)
        total_promo_amount += calculate_promotion_for_items(promotion, promotion_items)
      end
      total_promo_amount
    end

    def fetch_promotion_items(promotion)
      order_items.select do |order_item|
        order_item.pizza.name == promotion.target && order_item.pizza_size.name == promotion.target_size && order_item.promotion_item != true
      end
    end

    def calculate_promotion_for_items(promotion, items)
      return 0 if items.length < (promotion.from + promotion.to)

      free_items_count = (items.length / promotion.from) * promotion.to
      items.take(free_items_count).map { |e| e.promotion_item = true } if free_items_count.positive?
      free_items_count * items.first.pizza_price
    end

    def apply_discounts(amount)
      return amount unless order.discounts.present?

      discount_percentage = order.discounts.sum(:discount)
      amount - ((amount * discount_percentage) / 100)
    end
  end
end
