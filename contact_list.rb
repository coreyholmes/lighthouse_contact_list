require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList
  LINE = "-".yellow * 30
  # @contacts = CSV.read('contacts.csv')
  # -----------------------
  # Make new contact
  # -----------------------
  
  def new_contact
    puts "Enter name: "
    name = STDIN.gets.chomp.capitalize
    
    puts "Enter email: "
    email = STDIN.gets.chomp.downcase
    
    puts "Enter mobile: "
    mobile = STDIN.gets.chomp

    Contact.create(name, email, mobile)
  end

  # -----------------------
  # List all contacts
  # -----------------------
  
  def list_all
    system "clear"
    Contact.all.each do |hash| 
      hash.each do |key, value|
        puts "#{key.white.on_blue.bold}: #{value}"
        puts LINE
      end
      puts " ".on_yellow * 30 
      puts LINE
    end 
  end

  # -----------------------
  # Show a single contact
  # -----------------------
  
  def search_id
    system "clear"
    print "Enter ID: "
    id = STDIN.gets.chomp.to_i
      puts LINE
    Contact.find(id).each do |key, value|
      puts "#{key.white.on_blue.bold}: #{value}"
      puts LINE
    end
  end

  # -----------------------
  # Seach through contacts
  # -----------------------
  
  def search
    system "clear"
    puts "Search by [1]Name [2]Email"
    input = STDIN.gets.chomp
    case input
    when "1"
      print "Enter name: "
      contact_name = STDIN.gets.chomp.capitalize
      puts Contact.search("name", contact_name)
    when "2"
      print "Enter email: "
      contact_email = STDIN.gets.chomp.downcase
      puts Contact.search("email", contact_email)
    end
  end
end #end of Class

case ARGV[0].downcase
when  "new_contact"
  contact_list = ContactList.new
  contact_list.new_contact
when  "list_all"
  contact_list = ContactList.new
  contact_list.list_all
when  "find"
  contact_list = ContactList.new
  contact_list.search_id
when  "search"
  contact_list = ContactList.new
  contact_list.search
end


