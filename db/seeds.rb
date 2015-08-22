# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = Category.create([{ name: 'Entrée', order: 1, active: true},
                              { name: 'Main', order: 2, active: true},
                              { name: 'Dessert', order: 1, active: true}])
