# frozen_string_literal: true

class OderOffer < ApplicationRecord
  belongs_to :order
  belongs_to :promotion, foreign_key: :offer_id, optional: true
  belongs_to :discount, foreign_key: :offer_id, optional: true
end
