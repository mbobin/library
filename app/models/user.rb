class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, #:registerable,
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  has_many :collections
  enum role: {
    regular: 1,
    admin: 10,
  }
end
