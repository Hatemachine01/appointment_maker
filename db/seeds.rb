# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




admin_1 = User.create(name: "julio" ,  email: "juliodevasquez@gmail.com" , last_name: "vasquez" , password: "admin", status: true)
admin_2 = User.create(name: "freddy",  email: "freddy@email.com" ,		last_name: "peña" ,  password: "admin", status: true)