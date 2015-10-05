require "nupack/version"

class Estimate
	attr_accessor :value, :people, :material, :price
	def initialize(value, people, material)
		@value = format_value(value)
		@people = format_people(people)
		@material = material

		return calculate_price
	end

	private
		def format_value(value)
			clean_value = value.gsub('$','').gsub('.','')
			raise "Invalid value input!" if clean_value.match(/\d/).nil? # cannot be nil value
			raise "Invalid value input!" if !clean_value.match(/\D/).nil? # cannot have non-digit chars
			
			value.gsub('$','').to_f*100
		end

		def format_people(people)
			people_match = people.match(/^\d+/)
			raise "Invalid person input!" if people_match.nil? # cannot be nil people
			people_match[0].to_f
		end

		def calculate_price
			price = '%.2f' % ((markup_flat + markup_people + markup_materials).to_f/100.00)
			@price = "$#{price}"
		end

		def markup_flat
			@value*1.05
		end

		def markup_people
			markup_flat*@people*0.012
		end

		def markup_materials
			if @material == "drugs"
				markup_flat*0.075
			elsif @material == "food"
				markup_flat*0.13
			elsif @material == "electronics"
				markup_flat*0.02
			else
				0
			end
		end  
end
