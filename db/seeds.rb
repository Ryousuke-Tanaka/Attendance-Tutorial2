# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# coding: utf-8

User.create!(name: "Sample User",
						 email: "sample@email.com",
						 password: "password",
						 password_confirmation: "password",
						 admin: true)
						 
60.times do |n|
	name = Faker::Name.name
	email = "sample-#{n+1}@email.com"
	password = "password"
	User.create!(name: name,
							 email: email,
							 password: password,
							 password_confirmation: password)
end