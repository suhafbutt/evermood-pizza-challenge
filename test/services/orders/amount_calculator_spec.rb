# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Orders::AmountCalculator, type: :model do
  let(:pizza_small) { create(:pizza, name: 'Margherita', price: 5) }
  let(:pizza_large) { create(:pizza, name: 'Salami', price: 8) }
  let(:pizza_size_small) { create(:pizza_size, name: 'Small', multiplier: 0.7) }
  let(:pizza_size_large) { create(:pizza_size, name: 'Large', multiplier: 1.3) }
  let(:order) { create(:order) }

  let!(:order_item_1) { create(:order_item, order: order, pizza: pizza_small, pizza_size: pizza_size_small) }
  let!(:order_item_2) { create(:order_item, order: order, pizza: pizza_large, pizza_size: pizza_size_large) }

  describe '#total_amount' do
    subject { described_class.new(order).total_amount }

    context 'when calculating total amount' do
      it 'calculates the base amount correctly' do
        base_amount = order_item_1.amount + order_item_2.amount
        expect(subject).to eq(base_amount)
      end

      it 'rounds the final amount to 2 decimal places' do
        expect(subject).to eq(subject.round(2))
      end
    end

    context 'when promotion is applied' do
      let!(:promotion) { create(:offer, :promotion, target: 'Salami', target_size: 'Large', from: 2, to: 1) }
      let!(:order_offer) { create(:order_offer, order: order, offer_id: promotion.id) }

      before do
        create(:order_item, order: order, pizza: pizza_large, pizza_size: pizza_size_large)
        create(:order_item, order: order, pizza: pizza_large, pizza_size: pizza_size_large)
      end

      it 'calculates the promotion amount correctly' do
        expect(subject).to eq(24.3)
      end
    end

    context 'when discount is applied' do
      let!(:discount) { create(:offer, :discount, discount: 5) }
      let!(:order_offer) { create(:order_offer, order: order, offer_id: discount.id) }

      it 'calculates the discount correctly' do
        total_without_discount = order_item_1.amount + order_item_2.amount
        discounted_amount = total_without_discount - (total_without_discount * (5.0 / 100))
        expect(subject).to eq(discounted_amount.round(2))
      end
    end

    context 'when no promotions or discounts are applied' do
      let!(:order_item_3) { create(:order_item, order: order, pizza: pizza_small, pizza_size: pizza_size_large) }

      it 'calculates the total amount without promotions and discounts' do
        total_amount = order_item_1.amount + order_item_2.amount + order_item_3.amount
        expect(subject).to eq(total_amount)
      end
    end
  end
end
