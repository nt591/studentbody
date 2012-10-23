# requires app file
# 	(only requires objects)


# create command line.
# greeting string : "hello!"
# "Enter your search query"


# while not exit
# 	if "list": output all names and only names
# 	if "search x" where x = last name
# 	if error or "help" - "type list, search x, or exit"
# exit


require_relative 'studentbody'


puts "hello, welcome to studentbody command line!"

def search(lastname)
	student = StudentBody::Student.findbylast(lastname)
	# if the attribute is githubfeed or twitterfeed, skip that output
	 StudentBody::Student.attributes.each do |attribute| 
		unless attribute == :twitterfeed || attribute == :githubfeed
			puts "#{attribute}: #{student.send(attribute)}" 
		end
	 end
end

def list
	StudentBody::Student.list_all
end	



selection = ""
until selection == "exit"
	puts "enter your search query:"
	selection = gets.downcase.chomp
	case selection
	when /search\s.*/
		begin
			argument = selection.split[1]
			search(argument)
		rescue
			puts "That last name does not exist. IDIOT."
		end

	when "list"	
		list
	when "help"
		puts "You can type 'list' to see all names, or you can search by last name (search X) for an individual's information."
	else
		puts "I don't understand. Please use list or help, or search by last name."
	end

end



# puts StudentBody::Student.findbylast('Streiter')

# puts StudentBody::Student.findbylast('Thomas')
# aaron = StudentBody::Student.new
# aaron.first_name = "Aaron"
# puts aaron.first_name








