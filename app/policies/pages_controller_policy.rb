class PagesControllerPolicy < ApplicationPolicy
  attr_reader :user, :record

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def profile?
    # puts "Current user: #{user.username}"
    # puts "Profile page: #{record.username}. Can see profile : #{record.private ? 'Yes' : 'No'}"
    if user == record || user.friends.include?(record)
      true
    else
      !record.private
    end
  end
end
