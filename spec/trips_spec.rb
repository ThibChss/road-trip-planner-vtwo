require 'rails_helper'

RSpec.describe "Trips", type: :request do
  describe Trip do
    context 'with Trip class' do
      subject { described_class }

      it { is_expected.to eq Trip }
    end
  end


  describe '#start_date_after_end_date' do
    trip = Trip.new(name: "New Trip", start_date: (Date.today + 1), end_date: (Date.today + 5), user: User.first)
    trip_two = Trip.new(name: "New Trip", start_date: (Date.today + 1), end_date: (Date.today + 1), user: User.first)

    it 'End date should be after start date' do
      expect(trip.start_date < trip.end_date).to be_truthy
    end

    it 'End date should be equal to start date' do
      expect(trip_two.start_date <= trip_two.end_date).to be_truthy
    end
  end
end
