# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :pizza
  belongs_to :pizza_size

  attr_accessor :promotion_item

  def amount
    add_on_sum = add_on_price
    return pizza_price unless add_on_sum.positive?

    pizza_price + add_on_price
  end

  def pizza_price
    pizza.price * pizza_size.multiplier
  end

  def add_on_price
    ingredents = Ingredient.where(name: add)
    ingredents.map { |ingredent| ingredent.multiplier * pizza_size.multiplier }.sum
  end
end
