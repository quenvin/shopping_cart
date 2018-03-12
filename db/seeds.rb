# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'admin@admin.com', password: '123456', name: 'admin', admin: true)
User.create!(email: 'user@user.com', password: '123456', name: 'user', admin: false)

Product.create(name: 'Product 1', description: "Description for Product 1", price: 11.50)
Product.create(name: 'Product 2', description: "Description for Product 2", price: 50.60)
Product.create(name: 'Product 3', description: "Description for Product 3", price: 150.68)

Order.create(user_id: 2, transaction_num: 'asfaf24sd', status: 'Delivered')
Order.create(user_id: 2, transaction_num: '42qws3fsf', status: 'In Progress')

Ordersproduct.create(product_id: 1, order_id: 1)
Ordersproduct.create(product_id: 2, order_id: 1)
Ordersproduct.create(product_id: 3, order_id: 1)
Ordersproduct.create(product_id: 3, order_id: 1)

Ordersproduct.create(product_id: 1, order_id: 2)
Ordersproduct.create(product_id: 1, order_id: 2)
Ordersproduct.create(product_id: 1, order_id: 2)
Ordersproduct.create(product_id: 1, order_id: 2)
Ordersproduct.create(product_id: 2, order_id: 2)
Ordersproduct.create(product_id: 3, order_id: 2)
Ordersproduct.create(product_id: 3, order_id: 2)
