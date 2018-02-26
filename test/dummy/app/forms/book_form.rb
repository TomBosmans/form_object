class BookForm < FormObject::Base
  resource :book do
    field :title
  end

  resource :author do
    field :first_name
    field :last_name
    field :age
    field :birth_date
  end

  validates :author_first_name, :book_title, presence: true

  def self.create(params)
    book = Book.new(book_attributes)
    book.author = Author.new(author_attributes)
    book.save if form.new(params).valid?(book: book, author: book.author)
    persisted_book = book.persisted? ? book : nil
    yield(form, persisted_book)
  end

  def self.update(book, params)
    form = new(params)
    book.attributes = form.book_attributes
    book.author.attributes = form.author_attributes
    book.save if form.valid?(book: book, author: book.author)
    updated_book = form.errors.present? ? book : nil
    yield(form, updated_book) if block_given?
  end
end
