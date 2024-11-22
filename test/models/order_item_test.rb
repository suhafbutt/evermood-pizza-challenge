# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:pizza) }
    it { should belong_to(:pizza_size) }
  end

  describe '#amount' do
    let(:pizza_size) { create(:pizza_size, multiplier: 2.0) }
    let(:pizza) { create(:pizza, price: 10.0) }
    let(:order) { create(:order) }
    let(:order_item) { create(:order_item, pizza: pizza, pizza_size: pizza_size, order: order, add: []) }

    context 'when there are no add-ons' do
      it 'returns the pizza price based on the size multiplier' do
        expect(order_item.amount).to eq(20.0)
      end
    end

    context 'when there are add-ons' do
      let!(:ingredient) { create(:ingredient, name: 'Olives', multiplier: 2.0) }

      before do
        order_item.add = ['Olives']
      end

      it 'adds the add-on price to the pizza price' do
        expected_amount = (pizza.price * pizza_size.multiplier) + (ingredient.multiplier * pizza_size.multiplier)

        expect(order_item.amount).to eq(expected_amount)
      end
    end
  end

  describe '#pizza_price' do
    let(:pizza_size) { create(:pizza_size, multiplier: 1.0) }
    let(:pizza) { create(:pizza, price: 10.0) }
    let(:order_item) { create(:order_item, pizza: pizza, pizza_size: pizza_size) }

    it 'calculates the pizza price based on pizza price and pizza size multiplier' do
      expect(order_item.pizza_price).to eq(10.0)
    end
  end

  describe '#add_on_price' do
    let(:pizza_size) { create(:pizza_size, multiplier: 1.0) }
    let(:pizza) { create(:pizza, price: 10.0) }
    let!(:ingredient) { create(:ingredient, name: 'Olives', multiplier: 2.0) }
    let(:order_item) { create(:order_item, pizza: pizza, pizza_size: pizza_size, add: ['Olives']) }

    it 'calculates the add-on price based on ingredients and size multiplier' do
      expected_add_on_price = ingredient.multiplier * pizza_size.multiplier
      expect(order_item.add_on_price).to eq(expected_add_on_price)
    end
  end

  describe 'promotion_item attribute' do
    let(:order_item) { create(:order_item) }

    it 'allows setting and getting the promotion_item' do
      order_item.promotion_item = '2-for-1'
      expect(order_item.promotion_item).to eq('2-for-1')
    end
  end
end
