require 'csv'
require 'colorize'


# Represents a person in an address book.
class Contact

  attr_accessor :id, :name, :email, :mobile

  def initialize(id, name, email, mobile)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @mobile = mobile
    @email = email
  end


  # Provides functionality for managing a list of Contacts in a csv file.
  # The class methods below work with the csv file
  class << self

    # Returns an Array of Contacts loaded from the csv file.
    def all
      csv = CSV.open('contacts.csv', 'r')
      file = csv.to_a
      key, values = file.first, file[1..-1]
      values.map { |v| key.zip v }.map &:to_h    
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    def create(id, name, email, number)
     Contact.new(id, name, email, number)
     CSV.open("contacts.csv", "a+") do |csv|
       csv << [id, name, email, number]
     end
   end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      id -= 1
      all[id]
    end

    # Returns an array of contacts who match the given term.
    def search(search_key, search_value)
      all.find do |key, value| 
        key[search_key] == search_value
        search_key 
      end
    end

  end
end

# Contact.search("Corey")



