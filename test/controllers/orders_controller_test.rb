# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:order) { create(:order, state: 'OPEN') }

  describe 'GET #index' do
    before do
      create_list(:order, 3, state: 'OPEN')
      get :index
    end

    it 'assigns @orders with all orders in OPEN state' do
      expect(assigns(:orders).count).to eq(3)
      expect(assigns(:orders).all? { |order| order.state == 'OPEN' }).to be_truthy
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'PATCH #update' do
    context 'when the update is successful' do
      before do
        patch :update, params: { id: order.id }
      end

      it 'marks the order as completed' do
        order.reload
        expect(order.state).to eq('COMPLETED')
      end

      it 'redirects to the orders index with a success notice' do
        expect(response).to redirect_to(orders_path)
        expect(flash[:notice]).to eq('Order marked as completed.')
      end
    end

    context 'when the update fails' do
      before do
        allow_any_instance_of(Order).to receive(:update).and_return(false)
        patch :update, params: { id: order.id }
      end

      it 'renders the index template with unprocessable entity status' do
        expect(response).to render_template(:index)
        expect(response.status).to eq(422)
      end
    end
  end
end
