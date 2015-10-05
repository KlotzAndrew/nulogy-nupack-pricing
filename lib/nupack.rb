require "nupack/version"

class Estimate
	attr_accessor :value, :people, :catagorie, :price
	def initialize(value, people, catagory)
		@value = value
		@people = people
		@catagory = catagory
	end
  
end
