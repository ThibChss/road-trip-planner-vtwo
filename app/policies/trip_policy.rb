class TripPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  # def trips?
  #   true
  # end

  def index?
    true if user
  end

  def show?
    true if record.participants.include?(user)
  end

  def calendar?
    true if user
  end

  def week_calendar?
    true if user
  end

  def month_calendar?
    true if user
  end

  def new?
    true if user
  end

  def create?
    true
  end
end
