# date.next_month can be used to
# put 30 days for books to be returned
require 'yaml'
require 'date'

class Library
  attr_accessor :collection, :return_date

  def initialize
    @collection = YAML.load_file('./lib/data.yml')
  end

  def search(_book)
    @collection.select { |book| book[:item][:title] == book }
  end

  def available_books
    @collection.select { |book| book[:available] == true }
  end

  def book_return_date
    Date.today.next_month
  end

  def checkout_book(title)
    book = @collection.detect { |book| book[:item][:title] == title }
    # binding.pry
    if book[:available] == true
      book[:available] = false
      book[:return_date] = book_return_date
      return { message: 'Checkout of book success! Please return by:', date: Date.today.next_month }

    end
    File.open('./lib/data.yml', 'w') { |file| file.write collection.to_yaml }
  end
end
