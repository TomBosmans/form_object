# # Check dummy/app/forms/book_form.rb to understand the tests

# require 'test_helper'

# describe BookForm do
#   describe '.resource' do
#     it 'has book_attributes' do
#       assert BookForm.new.respond_to? :book_title
#     end

#     it 'has author_attributes' do
#       assert BookForm.new.respond_to?(:author_first_name) &&
#              BookForm.new.respond_to?(:author_last_name)
#     end

#     it 'creates book_attributes method' do
#       assert BookForm.new.respond_to?(:book_attributes)
#     end

#     it 'creates author_attributes method' do
#       assert BookForm.new.respond_to?(:author_attributes)
#     end
#   end

#   describe '#book_attributes' do
#     it 'contains title' do
#       form = BookForm.new
#       assert form.book_attributes.include? :title
#     end
#   end

#   describe '#author_attributes' do
#     it 'contains first_name' do
#       form = BookForm.new
#       assert form.author_attributes.include? :first_name
#     end

#     it 'contains last_name' do
#       form = BookForm.new
#       assert form.author_attributes.include? :last_name
#     end
#   end

#   describe '.new' do
#     it 'can set book attributes' do
#       title = 'There and back again'
#       book = Book.new(title: title)
#       form = BookForm.new(book: book)
#       assert_equal title, form.book_title
#     end
#   end

#   describe '#valid?' do
#     it 'gives error when form not valid' do
#       form = BookForm.new
#       form.valid?
#       assert form.errors.present?
#     end

#     it 'gives error when book not valid' do
#       form = BookForm.new(
#         book_title: 'There and back again',
#         author_last_name: 'Tolkien',
#         author_first_name: 'J.R.R'
#       )
#       book = Book.new

#       form.valid?(book: book)
#       assert form.errors.present?
#     end
#   end

#   describe 'create book and author' do
#     it 'can create a book with an author' do
#       params = {
#         book_title: 'There and back again',
#         author_first_name: 'J.R.R',
#         author_last_name: 'Tolkien'
#       }

#       form = BookForm.new(params)
#       book = Book.create(form.book_attributes)
#       book.author = Author.create(form.author_attributes)
#       assert book.title == params[:book_title] &&
#              book.author.last_name == params[:author_last_name] &&
#              book.author.first_name == params[:author_first_name]
#     end

#     it 'can update book and author' do
#       book = Book.create(title: 'hallo world')
#       book.author = Author.create(first_name: 'Tom', last_name: 'Bosmans')

#       params = {
#         book_title: 'bye_world',
#         author_first_name: 'John',
#         author_last_name: 'Doe'
#       }

#       form = BookForm.new(params)
#       book.attributes = form.book_attributes
#       book.author.attributes = form.author_attributes
#       book.save

#       assert book.title == params[:book_title] &&
#              book.author.last_name == params[:author_last_name] &&
#              book.author.first_name == params[:author_first_name]
#     end
#   end
# end
