# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(uname:  "exampleuser",
             fname: "Example",
             lname: "User",
             email: "example@moneyapp.com",
             password:              "foobar",
             password_confirmation: "foobar")

19.times do |n|
  fname  = Faker::Name.first_name
  lname = Faker::Name.last_name
  uname = Faker::Internet.user_name(fname)
  email = "example-#{n+1}@moneyapp.com"
  password = "password"
  User.create!(uname:  uname,
               fname: fname,
               lname: lname,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
10.times do
  amount = Faker::Number.number(2)
  rand_num = rand(1..10)
  sharing_user = User.find_by(id: rand_num)
  users.each { |user| user.expenses.create!(amount: amount, sharing_user: sharing_user) }
end
