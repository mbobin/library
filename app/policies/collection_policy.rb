class CollectionPolicy < ApplicationPolicy
  def index?
    !!user
  end

  def create?
    !!user
  end

  def update?
    !!user
  end
end
