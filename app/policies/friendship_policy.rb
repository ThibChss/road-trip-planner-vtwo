class FriendshipPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    true if user
  end

  def destroy?
    true if user
  end

  def remove?
    true if user
  end

  def remove_mutual?
    true if user
  end
end
