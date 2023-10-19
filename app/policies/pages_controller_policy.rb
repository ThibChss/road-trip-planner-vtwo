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
    check_friends?
  end

  def friends?
    check_friends?
  end

  def pending_friends?
    user_record?
  end

  def invitations?
    user_record?
  end

  def search_friends?
    user_record?
  end

  def check_friends?
    if user == record || user.friends.include?(record)
      true
    else
      !record.private
    end
  end

  def user_record?
    user == record
  end
end
