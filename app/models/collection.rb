class Collection < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :books, -> { select(:id, :name).order(:created_at) }

  validates :name, presence: true
end
