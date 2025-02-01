puts 'Destroying all data...'
DatabaseCleaner.clean_with(:truncation)
puts 'Starting fresh 🧃'

# CREATING USERS
puts 'Creating users'
users = []

puts 'Creating you...'
you = User.create!(
  username: 'Thibault',
  first_name: 'Thibault',
  last_name: 'Chssn',
  email: 'thib@gmail.com',
  private: false,
  password: 'password'
)
users << you

# Creating two more users
%w[Theo Louis Quentin].zip(%w[NY Le Bubu]).each do |first_name, last_name|
  user = User.create!(
    username: first_name,
    first_name:,
    last_name:,
    email: "#{first_name}@gmail.com",
    private: [true, false].sample,
    password: 'password'
  )
  users << user
end

puts "3 users created!"

# CREATING TRIP
puts 'Creating a trip ✈️'
trip = Trip.create!(
  name: 'Trip to the moon',
  start_date: Date.current,
  end_date: Date.current + 5.days,
  user_id: you.id,
  photo_url: Faker::LoremFlickr.image(search_terms: ['travel'])
)

puts "Trip created: #{trip.name}"

# ADDING PARTICIPANTS
puts 'Adding participants'
users.each do |user|
  next if user == you

  trip.participations.create!(user_id: user.id, admin: false)
end

puts "Participants added!"

# ADDING EVENTS TO TRIP
puts 'Creating events'

price_details = [
  { paid_by: "theo@gmail.com", paid_for: ["louis@gmail.com", "quentin@gmail.com", "thib@gmail.com"], amount: 39_100 },
  { paid_by: "thib@gmail.com", paid_for: ["quentin@gmail.com", "louis@gmail.com"], amount: 29_500 },
  { paid_by: "louis@gmail.com", paid_for: ["quentin@gmail.com", "thib@gmail.com", "louis@gmail.com"], amount: 36_300 },
  { paid_by: "louis@gmail.com", paid_for: ["theo@gmail.com", "louis@gmail.com"], amount: 32_300 },
  { paid_by: "theo@gmail.com", paid_for: ["thib@gmail.com", "louis@gmail.com", "quentin@gmail.com"], amount: 45_100 },
  { paid_by: "thib@gmail.com", paid_for: ["thib@gmail.com", "quentin@gmail.com"], amount: 28_400 },
  { paid_by: "quentin@gmail.com", paid_for: ["louis@gmail.com", "theo@gmail.com"], amount: 5300 },
  { paid_by: "quentin@gmail.com", paid_for: ["theo@gmail.com", "thib@gmail.com"], amount: 24_400 },
  { paid_by: "theo@gmail.com", paid_for: ["theo@gmail.com", "louis@gmail.com", "quentin@gmail.com"], amount: 25_300 },
  { paid_by: "thib@gmail.com", paid_for: ["theo@gmail.com", "louis@gmail.com", "quentin@gmail.com"], amount: 35_400 }
]

price_details.each do |price_detail|
  event_start = Faker::Date.between(from: trip.start_date, to: trip.end_date - 1).to_datetime
  event_end = event_start + rand(1..3).hours

  event = TripEvent.create!(
    name: Faker::Restaurant.name,
    creator_id: users.sample.id,
    trip_id: trip.id,
    start_date: event_start,
    end_date: event_end,
    category: TripEvent::CATEGORIES.values.flatten.sample
  )

  # Creating a price for the event
  price = Price.create!(
    paid_by_id: User.find_by(email: price_detail[:paid_by]).id,
    trip_event_id: event.id,
    total_paid: price_detail[:amount]
  )

  # Creating an address for the event
  Address.create!(
    trip_event_id: event.id,
    address: Faker::Address.full_address
  )

  # Simulating payments for random participants
  price_detail[:paid_for].each do |email|
    PaidForTripEvent.create!(
      user_id: User.find_by(email: email).id,
      price_id: price.id
    )
  end
end

puts 'Events created!'
