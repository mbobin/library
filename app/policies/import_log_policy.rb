class ImportLogPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
