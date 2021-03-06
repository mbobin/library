class Book < ApplicationRecord
  include PgSearch
  attr_accessor :update_from_isbn

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :collections
  has_many :versions, dependent: :destroy
  has_many :pdf_versions, -> { pdf_books }, class_name: "Version"
  has_many :downloadable_versions, -> { downloadable_books }, class_name: "Version"

  scope :with_tag, ->(tag) {
    where("? = ANY(tags)", tag)
  }

  pg_search_scope :search_by_name, against: :name, using: { trigram: { threshold: 0.85 } }
  pg_search_scope :search, against: [
    [:name, 'A'],
    [:tags, 'A'],
    [:description, 'B'],
  ],
  using: { tsearch: { any_word: true, prefix: true } }
end

