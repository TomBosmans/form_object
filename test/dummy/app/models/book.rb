class Book < ApplicationRecord
  belongs_to :author

  validates :title, length: { maximum: 5 }
end
