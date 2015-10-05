require "nupack/version"

class Estimate
	attr_accessor :value, :people, :catagory, :price
	def initialize(value, people, catagory)
		@value = value.gsub('$','').to_f*100
		@people = people.split.first.to_i
		@catagory = catagory

		calculate_markup
	end

	private

		def calculate_markup
			@price = ((markup_flat + markup_people + markup_materials).to_f/100.00).round(2)
		end

		def markup_flat
			@value*1.05
		end

		def markup_people
			markup_flat*@people*0.012
		end

		def markup_materials
			if @catagory == "drugs"
				markup_flat*0.075
			elsif @catagory == "food"
				markup_flat*0.13
			elsif @catagory == "electric"
				markup_flat*0.02
			else
				0
			end
		end  
end
