class DocumentPolicy < ApplicationPolicy
  def convert?
    user&.admin?
  end
end
