# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should have_many(:order_items) }
    it { should have_many(:order_offer) }
    it { should have_many(:promotions).through(:order_offer) }
    it { should have_many(:discounts).through(:order_offer) }
  end

  describe '#amount' do
    let(:order) { create(:order) }
    let(:order_item) { create(:order_item, order: order) }

    it 'calculates the correct order amount' do
      expect(order.amount).to eq(7)
    end
  end

  describe 'callbacks' do
    it 'sets a uuid before creating the order' do
      order = build(:order, uuid: nil)
      expect(order.uuid).to be_nil
      order.save
      expect(order.uuid).to be_present
    end

    it 'does not overwrite the uuid if already present' do
      order = build(:order, uuid: 'existing-uuid')
      order.save
      expect(order.uuid).to eq('existing-uuid')
    end
  end
end
