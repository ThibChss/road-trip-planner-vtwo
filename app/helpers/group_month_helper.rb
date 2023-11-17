module GroupMonthHelper
  def group_month(trip)
    from = trip.start_date.to_date.prev_occurring(:monday)
    to = trip.end_date.to_date.next_occurring(:sunday)
    (from..to).group_by(&:month).map do |group|
      group.last.first.beginning_of_month..group.last.last.end_of_month
    end
  end
end
