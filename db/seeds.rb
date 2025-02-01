puts 'Destroying all data...'
# [Participant, Friendship, Price, PaidForTripEvent, Address, TripEvent, Trip, User].each(&:delete_all)
DatabaseCleaner.clean_with(:truncation)
puts 'All data destroyed!'

# CREATING USERS
puts 'Creating users 🙍🏻'
TOTAL_USERS = 10_000
TOTAL_FRIENDSHIPS = 50_000
TOTAL_TRIPS = 500
EVENTS_PER_TRIP = 25

users = []

puts 'Creating you...'
you = User.create!(
  username: 'Thibault',
  first_name: 'Thibault',
  last_name: 'Chssn',
  email: 'thib@gmail.com',
  private: [true, false].sample,
  password: 'password'
)
users << you

user_records = []
TOTAL_USERS.times do |i|
  user_records << {
    username: Faker::Internet.username(specifier: 5..10),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    private: [true, false].sample,
    encrypted_password: 'password'
  }
  puts "Prepared user #{i + 1}" if (i % 1000).zero?
end

User.insert_all!(user_records) # Bulk insert users
users += User.all.to_a # Fetch all users in memory
puts "#{TOTAL_USERS} users created!"

# CREATING FRIENDSHIPS
puts 'Creating friendships 💞'
friendship_records = []

TOTAL_FRIENDSHIPS.times do |i|
  user = users.sample
  friend = users.sample
  next if user == friend # Skip self-friendship

  friendship_records << { user_id: user.id, friend_id: friend.id, status: [true, false].sample, created_at: Time.now, updated_at: Time.now }
  friendship_records << { user_id: friend.id, friend_id: user.id, status: [true, false].sample, created_at: Time.now, updated_at: Time.now }

  puts "Prepared friendship #{i + 1}" if (i % 1000).zero?
end

Friendship.insert_all!(friendship_records) # Bulk insert friendships
puts "#{TOTAL_FRIENDSHIPS} friendships created!"

# CREATING TRIPS
puts 'Creating trips ✈️'
trip_records = []

TOTAL_TRIPS.times do |i|
  trip_records << {
    name: Faker::Lorem.words(number: 3).join(' ').titleize,
    start_date: Faker::Date.forward(days: 30),
    end_date: Faker::Date.forward(days: 50),
    user_id: users.sample.id,
    photo_url: Faker::LoremFlickr.image(search_terms: ['travel']),
    created_at: Time.now,
    updated_at: Time.now
  }
  puts "Prepared trip #{i + 1}" if (i % 100).zero?
end

Trip.insert_all!(trip_records) # Bulk insert trips
trips = Trip.all.to_a
puts "#{TOTAL_TRIPS} trips created!"

# ADDING PARTICIPANTS
puts 'Adding participants 🧍🏻🧍🏻‍♀️'
participant_records = []

trips.each_with_index do |trip, i|
  trip_users = users.sample(rand(50..100)) # Each trip gets 50-100 participants
  trip_users.each do |user|
    participant_records << { user_id: user.id, trip_id: trip.id, created_at: Time.now, updated_at: Time.now }
  end
  puts "Prepared participants for trip #{i + 1}" if (i % 10).zero?
end

Participant.insert_all!(participant_records) # Bulk insert participants
puts 'Participants added!'

# ADDING EVENTS TO TRIPS
puts 'Creating events 🕺🏻'
price_records = []
address_records = []
paid_for_records = []

trips.each_with_index do |trip, i|
  trip_events = []
  EVENTS_PER_TRIP.times do
    event_start = Faker::Date.between(from: trip.start_date, to: trip.end_date - 2).to_datetime
    event_end = event_start + rand(1..3).hours

    trip_events << {
      name: Faker::Restaurant.name,
      creator_id: trip.participants.sample.id,
      trip_id: trip.id,
      start_date: event_start,
      end_date: event_end,
      category: TripEvent::CATEGORIES.values.flatten.sample,
      created_at: Time.now,
      updated_at: Time.now
    }
  end

  # Insert events in bulk and retrieve their IDs
  inserted_events = TripEvent.insert_all!(trip_events, returning: %w[id trip_id creator_id])
  inserted_event_ids = inserted_events.pluck('id')

  # Create associated prices, addresses, and paid_for records
  inserted_event_ids.each do |event_id|
    paid_by = trip.participants.sample.id
    total_paid = rand(50..500)

    price_records << {
      paid_by_id: paid_by,
      trip_event_id: event_id,
      total_paid: total_paid,
      created_at: Time.now,
      updated_at: Time.now
    }

    address_records << {
      trip_event_id: event_id,
      address: Faker::Address.full_address,
      created_at: Time.now,
      updated_at: Time.now
    }

    # Simulate payments for random participants
    price_participants = trip.participants.sample(rand(5..20))
    price_participants.each do |participant|
      paid_for_records << {
        user_id: participant.id,
        price_id: nil, # Will update later after inserting prices
        created_at: Time.now,
        updated_at: Time.now
      }
    end
  end

  puts "Prepared events for trip #{i + 1}" if (i % 10).zero?
end

# Insert prices and fetch their IDs
inserted_prices = Price.insert_all!(price_records, returning: %w[id trip_event_id])
inserted_price_ids = inserted_prices.pluck('id')

# Update `price_id` in `paid_for_records` with the correct IDs
paid_for_records.each do |record|
  record[:price_id] = inserted_price_ids.sample
end

# Bulk insert paid_for records
PaidForTripEvent.insert_all!(paid_for_records)

# Bulk insert addresses
Address.insert_all!(address_records)

puts 'Events created!'
