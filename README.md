# FormObject
This gem is an extraction from my Magnus project. It is an experiment on how to implement form objects in rails.

## Usage

### Example FormObject
```ruby
class BookForm < FormObject::Base
  # self.default_resource = :author # fields not in a block will be added to :author
  field :description # this will be added to :book resource.

  resource :book do
    field :title
  end

  resource :author do
    field :first_name
    field :last_name
  end

  validates :author_first_name, :book_title, presence: true

  def self.create(params)
    book = Book.new(book_attributes)
    book.author = Author.new(author_attributes)
    book.save if form.new(params).valid?(book: book, author: book.author)
    persisted_book = book.persisted? ? book : nil
    yield(form, persisted_book) if block_given?
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
```

### Used in controller actions
```ruby
def new
  @form = BookForm.new
end

def create
  BookForm.create(params) do |form, book|
    if book
	  redirect_to book
    else
      render :new
    end
  end
end

def edit
  book = Book.find(params(:id)
  @form = BookForm.new(book: book, author: book.author)
end

def update
  book = Book.find(params[:id])
  BookForm.update(book, params) do |form, updated_book|
    if updated_book
     redirect_to updated_book
    else
     render :edit
    end
  end
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'form_object', git: 'https://github.com/TomBosmans/form_object'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install form_object
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
