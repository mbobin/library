class Version < ApplicationRecord
  belongs_to :book
  has_many :documents, dependent: :destroy
  enum book_type: {
    pdf: 0, epub: 1, mobi: 2, doc: 3, docx: 4, audio: 5,
    azw: 6, fb2: 10, htmlz: 11, lrf: 12, pdb: 13,
    prc: 14, rtf: 15, tpz: 16, txtz: 17, txt: 18,
  }, _suffix: "books"

  scope :downloadable_books, -> { where(book_type: book_types.except(:pdf).values) }
end
