class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user == record
  end
end