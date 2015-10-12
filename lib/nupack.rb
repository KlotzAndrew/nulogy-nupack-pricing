require "nupack/version"

class Estimate
	attr_accessor :value, :people, :material
	attr_reader :price

	MATERIAL_MARKUP = {
		"drugs" => 0.075,
		"food" => 0.13,
		"electronics" => 0.02
	}
	PEOPLE_MARKUP = 0.012
	FLAT_MARKUP = 0.05

	def initialize(value, people, material)
		@value = parse_value(value)
		@people = parse_people(people)
		@material = material

		format_final_price(calculate_price)
	end

	private
		def parse_value(value)
			clean_value = value.gsub('$','').gsub('.','')
			value_nil?(clean_value)
			value_non_digits?(clean_value)
			value.gsub('$','').to_f
		end

		def value_nil?(clean_value)
			raise "Invalid value input!" if clean_value.match(/\d/).nil? 
		end

		def value_non_digits?(clean_value)
			raise "Invalid value input!" if !clean_value.match(/\D/).nil?
		end

		def parse_people(people)
			people_match = people.match(/^\d+/)
			raise "Invalid person input!" if people_match.nil?
			people_match[0].to_f
		end

		def calculate_price
			set_markup_base + add_markup_people + add_markup_materials
		end

		def set_markup_base
			@value + @value*FLAT_MARKUP
		end

		def add_markup_people
			set_markup_base*@people*PEOPLE_MARKUP
		end

		def add_markup_materials
			markup = MATERIAL_MARKUP["#{@material}"] || 0
			set_markup_base*markup
		end  

		def format_final_price(raw_price)
			price = '%.2f' % raw_price
			@price = "$#{price}"
		end
end
