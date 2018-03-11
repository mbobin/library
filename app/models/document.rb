class Document < ApplicationRecord
  belongs_to :version
  has_one :book, through: :version
  has_one_attached :file
end
