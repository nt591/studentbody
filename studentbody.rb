require 'sqlite3'
require 'sinatra'
require 'fileutils'

aa = "Aaron"

class StudentBody < Sinatra::Base 

  get '/' do
    @indexed_students = Student.all
    erb :index
  end

  get '/:fullname' do 
    @student = Student.find(params[:fullname])
    erb :profile
  end


  class Student

    

    @db = SQLite3::Database.open('db/studentbody.db')

    @db.results_as_hash = true
    
    keys = @db.execute("SELECT * FROM students INNER JOIN indexstudents ON students.last_name = indexstudents.last_name").first.map do |key, value|
      key.to_sym if key.class == String
    end

    @@attributes = keys.compact!
    
    
    @@attributes.each do |attribute|
      attr_accessor attribute
    end

    def self.findbylast(lastname)
      student = Student.new
      @db.results_as_hash = true
      lastname = lastname.capitalize
      result = @db.execute("SELECT * FROM students WHERE last_name = ?", lastname)[0]

      @@attributes.each do |attribute|
        student.send("#{attribute}=", result[attribute.to_s])
      end
        student

    end

    def self.attributes
      @@attributes
    end

    def self.find(fullname)
      first_name, last_name = fullname.split("-",2)
      student = Student.new
      @db.results_as_hash = true
      result = @db.execute("SELECT * FROM students WHERE first_name = '#{first_name.capitalize}' AND last_name = '#{last_name.capitalize}'")[0]
      @@attributes.each do |attribute|
        student.send("#{attribute}=", result[attribute.to_s])
      end
        student
    end

    def self.all
      #get every row from database, convert into object, put into array to pass into view
      @db.results_as_hash = true
      result = @db.execute("SELECT * FROM indexstudents")
      allstudents =[]
      result.each do |result|
        student = Student.new
        student.excerpt = result["excerpt"]
        student.tagline = result["tagline"]
        student.first_name = result["first_name"]
        student.last_name = result["last_name"]
        student.image_url = result["image_url"]
        student.page_link = result["page_link"]
        allstudents << student 
      end    
      allstudents
    
    end      

    def self.list_all
    	# call the list_all method on the object from the student class
    	# it should list all the first_name and last_name of students in order of ID
    	# first we call the database
    	# create objects for each person
    	# save to an array of objects

    	result = @db.execute("SELECT first_name, last_name FROM students")
    	result.each do |result|
    		student = Student.new
    		student.first_name = result["first_name"]
    		student.last_name = result["last_name"]
    		puts "#{student.first_name} #{student.last_name}"
    	end

    end
  
  end

end


# puts StudentBody::Student.attributes
#StudentBody.run!