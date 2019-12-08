class PostPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user == record.user || user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end