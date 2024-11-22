# frozen_string_literal: true

module OrdersHelper
  def offer_codes offers
    offers.pluck(:code).join(', ').presence
  end 
end
