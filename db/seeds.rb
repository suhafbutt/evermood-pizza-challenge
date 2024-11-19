# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

OrderItem.destroy_all
OderOffer.destroy_all
Pizza.destroy_all
PizzaSize.destroy_all
Ingredient.destroy_all
Offer.destroy_all
Order.destroy_all

margherita = Pizza.create!(name: 'Margherita', price: 5.0)
salami = Pizza.create!(name: 'Salami', price: 6.0)
tonno = Pizza.create!(name: 'Tonno', price: 8.0)

small = PizzaSize.create!(name: 'Small', multiplier: 0.7)
medium = PizzaSize.create!(name: 'Medium', multiplier: 1.0)
large = PizzaSize.create!(name: 'Large', multiplier: 1.3)

onion = Ingredient.create!(name: 'Onions', multiplier: 1)
cheese = Ingredient.create!(name: 'Cheese', multiplier: 2)
olives = Ingredient.create!(name: 'Olives', multiplier: 2.5)

promotion = Promotion.create!(code: '2FOR1', discount: 50, target: 'Salami', target_size: 'Small', from: 2, to: 1)
discount = Discount.create!(code: 'SAVE5', discount: 5)

order1 = Order.create!(state: 'OPEN')
OrderItem.create!(pizza_id: tonno.id, pizza_size: large, order: order1)

order2 = Order.create!(state: 'OPEN')
OrderItem.create!(pizza_id: margherita.id, pizza_size: large, add: [onion.name, cheese.name, olives.name],
                  order: order2)
OrderItem.create!(pizza_id: tonno.id, pizza_size: medium, remove: [onion.name, olives.name], order: order2)
OrderItem.create!(pizza_id: margherita.id, pizza_size: small, order: order2)

order3 = Order.create!(state: 'OPEN')
OrderItem.create!(pizza_id: salami.id, pizza_size: medium, add: ['Onions'], remove: ['Cheese'], order: order3)
OrderItem.create!(pizza_id: salami.id, pizza_size: small, add: [], remove: [], order: order3)
OrderItem.create!(pizza_id: salami.id, pizza_size: small, add: [], remove: [], order: order3)
OrderItem.create!(pizza_id: salami.id, pizza_size: small, add: [], remove: [], order: order3)
OrderItem.create!(pizza_id: salami.id, pizza_size: small, add: ['Olives'], remove: [], order: order3)

OderOffer.create!(order_id: order3.id, offer_id: promotion.id)
OderOffer.create!(order_id: order3.id, offer_id: discount.id)

puts 'Seed data successfully added!'
