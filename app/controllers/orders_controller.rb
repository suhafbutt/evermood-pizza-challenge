# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[update]

  def index
    @orders = Order.where(state: 'OPEN')
  end

  def update
    respond_to do |format|
      if @order.update(state: 'COMPLETED')
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@order) }
        format.html { redirect_to orders_path, notice: 'Order marked as completed.' }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_order
    @order = Order.find(params.expect(:id))
  end
end
