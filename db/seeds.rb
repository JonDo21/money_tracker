# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#users
User.create!(uname:  "exampleuser",
             fname: "Example",
             lname: "User",
             email: "example@moneyapp.com",
             password:              "foobar",
             password_confirmation: "foobar")

50.times do |n|
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

#expenses
users = User.order(:created_at).take(6)
10.times do
  amount = Faker::Number.number(2)
  rand_num = rand(1..10)
  sharing_user = User.find_by(id: rand_num)
  description = Faker::Lorem.word
  users.each { |user| user.expenses.create!(amount: amount, description: description, sharing_user: sharing_user) }
end

# Following friends
users = User.all
user  = users.first
following = users[10..40]
followers = users[3..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }