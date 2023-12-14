module ColorHelper
  def category_color(category)
    accomodations = [
      '🏨 Hotel',
      '🏠 Airbnb',
      '🏕️ Camping',
      '🏢 Hostel',
      '🏚️ House',
    ]
    activities = [
      '🍔 Food',
      '🍽️ Restaurant',
      '🍺 Drink',
      '🎨 Culture',
      '🏋🏻 Sport',
      '🎤 Entertainment',
      '🎭 Movie & Theater',
      '🏞️ Visit'
    ]
    transportations = [
      '✈️ Plane',
      '🚆 Train',
      '🚕 Taxi',
      '🚗 Car',
      '🚲 Bike',
      '🚊 Public Transport',
      '🚢 Boat',
    ]
    other = [
      '🏷️ Other',
      '🛒 Groceries'
    ]

    if category == '❓ Not Specified'
      '188, 92, 92'
    elsif accomodations.include?(category)
      '86, 149, 149'
    elsif activities.include?(category)
      '13, 99, 99'
    elsif transportations.include?(category)
      '6, 50, 50'
    elsif other.include?(category)
      '12, 29, 29'
    end
  end
end
