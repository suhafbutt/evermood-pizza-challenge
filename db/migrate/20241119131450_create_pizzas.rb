# frozen_string_literal: true

class CreatePizzas < ActiveRecord::Migration[8.0]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
