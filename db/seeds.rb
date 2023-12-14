# DELETING INSTANCES
puts 'Destroying trips ❌'
Trip.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying people 💀'
User.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying participation 📅'
Participant.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying friendships 🥹'
Friendship.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying events 👎🏻'
TripEvent.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying prices 💲'
Price.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying debts 🎉'
PaidForTripEvent.destroy_all
puts 'Done 👌🏻'
print "\n"

puts 'Destroying places 💣'
Address.destroy_all
puts 'Done 👌🏻'
print "\n"


print "\n"
print "\n"
print "\n"


# CREATING INSTANCES
puts 'Creating some users 🙍🏻'

people = {
  thibault: {
    username: 'Le Thib',
    first_name: 'Thibault',
    last_name: 'Chassine',
    email: 'thib@gmail.com'
  },
  quentin: {
    username: 'La Quen',
    first_name: 'Quentin',
    last_name: 'Brll',
    email: 'quen@gmail.com'
  },
  astrid: {
    username: 'La Jeune',
    first_name: 'Astrid',
    last_name: 'Flpv',
    email: 'astr@gmail.com'
  },
  antoine: {
    username: 'La Tute',
    first_name: 'Antoine',
    last_name: 'Blc',
    email: 'anto@gmail.com'
  },
  clea: {
    username: 'Kéké',
    first_name: 'Cléa',
    last_name: 'Drd',
    email: 'clea@gmail.com'
  },
  louis: {
    username: 'Le Louis',
    first_name: 'Louis',
    last_name: 'Lps',
    email: 'loui@gmail.com'
  },
  jeanne: {
    username: 'La Jane',
    first_name: 'Jeanne',
    last_name: 'Prt',
    email: 'jean@gmail.com'
  },
  marie: {
    username: 'Tow',
    first_name: 'Marie',
    last_name: 'Crdn',
    email: 'marie@gmail.com'
  },
  quitterie: {
    username: 'Kit',
    first_name: 'Quitterie',
    last_name: 'Urcl',
    email: 'quit@gmail.com'
  },
  eugenie: {
    username: 'Eugène',
    first_name: 'Eugénie',
    last_name: 'Lsn',
    email: 'euge@gmail.com'
  },
  margaux: {
    username: 'Marguiche',
    first_name: 'Margaux',
    last_name: 'Cts',
    email: 'marg@gmail.com'
  },
  theo: {
    username: 'Le T',
    first_name: 'Théo',
    last_name: 'Crd',
    email: 'theo@gmail.com'
  }
}

the_team = []

people.each do |_, infos|
  user = User.create(
    username: infos[:username],
    first_name: infos[:first_name],
    last_name: infos[:last_name],
    email: infos[:email],
    private: [true, false].sample,
    password: 'password'
  )
  the_team << user

  puts "All good for #{user.first_name} 👍🏻"
end

thib = User.first

quen = User.second

anto = User.fourth

30.times do
  user = User.create(
    username: Faker::Internet.username,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    private: [true, false].sample,
    password: 'password'
  )
  user.username = user.username.titleize

  puts "All good for #{user.first_name} 👍🏻"
end

puts 'Done 👌🏻'
print "\n"



puts 'Creating friends 💞'

users_team = User.where(id: the_team).where.not(id: [thib, quen, anto])

users_team.each do |user|
  Friendship.create(user: thib, friend: user, status: true)
  Friendship.create(user:, friend: thib, status: true)

  status = [true, false].sample

  Friendship.create(user: quen, friend: user, status: false)
  Friendship.create(user:, friend: anto, status: false)

  friends = users_team.where.not(id: user)
  friend = friends.sample

  Friendship.create(user: friend, friend: user, status:)
  Friendship.create(user:, friend:, status:)

  puts "#{user.first_name} and #{friend.first_name} are now friends 🫱🏻‍🫲🏻"
end

Friendship.create(user: thib, friend: quen, status: true)
Friendship.create(user: quen, friend: thib, status: true)

other_users = User.where.not(id: the_team)

other_users.each do |user|
  status = [true, false].sample
  everyone = User.where.not(id: user).where.not(id: thib)
  someone = everyone.sample

  Friendship.create(user:, friend: someone, status:)
  Friendship.create(user: someone, friend: user, status:)

  status = [true, false].sample
  Friendship.create(user: thib, friend: user, status:)
  Friendship.create(user:, friend: thib, status:)

  puts "#{user.first_name} and #{someone.first_name} are now friends 🫱🏻‍🫲🏻"
end

puts 'Done 👌🏻'
print "\n"



puts 'Creating the best trip ✈️'
best_trip = Trip.create(name: 'Best Trip Ever ☀️', start_date: Date.today, end_date: Date.today + 8, user: thib, photo_url: "https://images.unsplash.com/photo-1494822493217-c9840aba840c?auto=format&fit=crop&q=60&w=700&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YmVzdCUyMHRyaXB8ZW58MHx8MHx8fDA%3D")
puts "#{best_trip.name} created 🧳"
trip = Trip.create(name: 'Weekend Bourguignon 🍷', start_date: Date.today + 20, end_date: Date.today + 23, user: quen, photo_url: "https://images.unsplash.com/photo-1589819482236-b583fe65f1d5?auto=format&fit=crop&q=80&w=2670&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
puts "#{trip.name} created 🧳"
trip = Trip.create(name: "The Big 3.O's 🎉", start_date: Date.today + 100, end_date: Date.today + 105, user: anto, photo_url: "https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?auto=format&fit=crop&q=80&w=2670&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
puts "#{trip.name} created 🧳"
trip = Trip.create(name: 'IDK Where We Are 🆘', start_date: Date.today + 200, end_date: Date.today + 210, user: the_team.sample, photo_url: "https://images.unsplash.com/photo-1506773090264-ac0b07293a64?auto=format&fit=crop&q=80&w=2536&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
puts "#{trip.name} created 🧳"
trip = Trip.create(name: 'The Big Apple 🍎', start_date: Date.today + 70, end_date: Date.today + 80, user: the_team.sample, photo_url: "https://images.unsplash.com/photo-1602828889956-45ec6cee6758?auto=format&fit=crop&q=80&w=2532&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
puts "#{trip.name} created 🧳"
puts 'Done 👌🏻'
print "\n"



puts 'Adding participants 🧍🏻🧍🏻‍♀️'
the_team.each do |user|
  Participant.create(user:, trip: best_trip)
  puts "#{user.first_name} has been added to #{best_trip.name} 🎉"
end

trips = Trip.where.not(id: best_trip)

trips.each do |other_trip|
  the_team.each do |user|
    Participant.create(user:, trip: other_trip)
    puts "#{user.first_name} has been added to #{other_trip.name} 🎉"
  end

  other_users.sample(6).each do |user|
    Participant.create(user:, trip: other_trip)
    puts "#{user.first_name} has been added to #{other_trip.name} 🎉"
  end
end
puts 'Done 👌🏻'
print "\n"



puts 'Adding some events to the trip 🕺🏻'

Trip.find_each do |this_trip|
  20.times do
    date = ((this_trip.start_date + 1)...(this_trip.end_date - 1)).to_a.sample
    event = TripEvent.create!(
      name: Faker::Restaurant.name,
      creator: this_trip.participants.sample,
      trip: this_trip,
      start_date: date.to_datetime,
      end_date: (date + 1).to_datetime,
      category: TripEvent::CATEGORIES.values.flatten.sample
    )
    paid_by = this_trip.participants.sample
    paid_for = this_trip.participants.take(5)
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

    puts "The event @#{event.name} has been created for #{this_trip.name} ✅"
  end
end

puts 'Done 👌🏻'
print "\n"
