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
	student = StudentBody::Student.findbylast("#{lastname}")

	# StudentBody::Student.attributes.each do |attribute|
	# 	puts student.send attribute
	#  end
	
	 StudentBody::Student.attributes.each do |attribute|
		puts "#{attribute}: #{student.send(attribute)}"
	 end

end

def list
	puts StudentBody::Student.all
end	



selection = ""
until selection == "exit"
	puts "enter your search query:"
	selection = gets.downcase.chomp
	case selection
	when /search\s.*/
		argument = selection.split[1]
		search(argument)

	when "list"	
		puts list
	when "help"

	end

end



# puts StudentBody::Student.findbylast('Streiter')

# puts StudentBody::Student.findbylast('Thomas')
# aaron = StudentBody::Student.new
# aaron.first_name = "Aaron"
# puts aaron.first_name








