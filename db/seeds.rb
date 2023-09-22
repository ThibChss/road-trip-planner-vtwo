# DELETING INSTANCES
puts 'Destroying trips'
Trip.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying people'
User.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying participation'
Participant.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying friendships 🥹'
Friendship.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying events'
TripEvent.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying prices'
Price.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying debts'
PaidForTripEvent.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying places'
Address.destroy_all
puts 'Done 👌🏻'
print "\n"





# CREATING INSTANCES
puts 'Creating some users 🙍🏻'
thib = User.create(username: 'Le Thib', first_name: 'Thibault', last_name: 'Chassine', email: 'thib@gmail.com', password: 'password')
User.create(username: 'La Quen', first_name: 'Quentin', last_name: 'Brll', email: 'quen@gmail.com', password: 'password')
User.create(username: 'La Jeune', first_name: 'Astrid', last_name: 'Flpv', email: 'astr@gmail.com', password: 'password')
User.create(username: 'La Tute', first_name: 'Antoine', last_name: 'Blc', email: 'anto@gmail.com', password: 'password')
User.create(username: 'Kéké', first_name: 'Cléa', last_name: 'Drd', email: 'clea@gmail.com', password: 'password')
User.create(username: 'Le Louis', first_name: 'Louis', last_name: 'Lps', email: 'loui@gmail.com', password: 'password')
User.create(username: 'La Jane', first_name: 'Jeanne', last_name: 'Prt', email: 'jean@gmail.com', password: 'password')
User.create(username: 'Kit', first_name: 'Quitterie', last_name: 'Urcl', email: 'quit@gmail.com', password: 'password')
User.create(username: 'Marguiche', first_name: 'Margaux', last_name: 'Cts', email: 'marg@gmail.com', password: 'password')
User.create(username: 'Le T', first_name: 'Théo', last_name: 'Crd', email: 'theo@gmail.com', password: 'password')
puts 'Done 👌🏻'
print "\n"

puts 'Creating friends 💞'
users = User.where.not(id: thib)

users.each do |user|
  status = [true, false].sample
  Friendship.create(user: thib, friend: user, status:)
  Friendship.create(user:, friend: thib, status:)
end
puts 'Done 👌🏻'
print "\n"

puts 'Creating the best trip ✈️'
trip = Trip.create(name: 'Best Trip Ever ☀️', start_date: Date.today, end_date: Date.today + 8, user: thib)
puts 'Done 👌🏻'
print "\n"

puts 'Adding participants 🧍🏻🧍🏻‍♀️'
User.find_each do |user|
  Participant.create(user:, trip:)
end
puts 'Done 👌🏻'
print "\n"

puts 'Adding some events to the trip 🕺🏻'
20.times do
  date = ((trip.start_date + 1)...(trip.end_date - 1)).to_a.sample
  event = TripEvent.create!(
    name: Faker::Restaurant.name,
    creator: thib,
    trip:,
    start_date: date.to_datetime,
    end_date: (date + 1).to_datetime
  )
  paid_by = trip.participants.sample
  paid_for = trip.participants.take(5)
  price = Price.create(
    paid_by:,
    trip_event: event,
    total_paid: rand(50..150)
  )
  paid_for.each do |user|
    PaidForTripEvent.create(
      user:,
      price:
    )
  end
  Address.create(
    trip_event: event,
    address: Faker::Address.full_address
  )
end
puts 'Done 👌🏻'
print "\n"
