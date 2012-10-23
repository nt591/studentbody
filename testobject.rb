require_relative 'studentbody'

class Test
	def self.symbol
		@syms = [:school, :name]
	end
end

class Student
	attr_accessor :name, :school
end


aaron = Student.new
aaron.name = "Aaron"
aaron.school = "Flatiron"



# aaron.send(syms)
Test.symbol.each do |attr|

puts aaron.send attr

end
puts aaron.inspect
# puts StudentBody::Student.attributes