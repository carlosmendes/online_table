# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([{ name: 'Entrée', order: 1, active: true},
                              { name: 'Main', order: 2, active: true},
                              { name: 'Dessert', order: 3, active: true}])
                              
products = Product.create([{ name: 'Beer 50cl', short_name: 'Beer 50cl', price: 1, description: 'Sagres', active: true},
                           { name: 'Beer 75cl', short_name: 'Beer 75cl', price: 1.2, description: 'Sagres', active: true},
                           { name: 'Bitoque', short_name: 'Bitoque', price: 5, description: 'Com ovo', active: true}])
                           
users = User.create([{name: 'Manager', email: 'manager@demo.com', password: '123456', confirmed: true, manager: true},
                     {name: 'Waiter', email: 'waiter@demo.com', password: '123456', confirmed: true, waiter: true},
                     {name: 'Client', email: 'client@demo.com', password: '123456', confirmed: true, manager: false}])  
