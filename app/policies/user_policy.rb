class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user == record || user.admin?
  end
end