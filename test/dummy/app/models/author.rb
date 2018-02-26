class Author < ApplicationRecord
  has_many :books

  validates :last_name, presence: true
end
