class Book < ApplicationRecord
  include PgSearch

  has_and_belongs_to_many :authors
  has_many :versions, dependent: :destroy
  has_many :pdf_versions, -> { pdf_books }, class_name: "Version"
  has_many :downloadable_versions, -> { downloadable_books }, class_name: "Version"

  scope :with_tag, ->(tag) {
    where("? = ANY(tags)", tag)
  }
  pg_search_scope :search_by_name, against: :name, using: :trigram
end
