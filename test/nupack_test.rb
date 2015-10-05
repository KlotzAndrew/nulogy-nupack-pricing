require 'test_helper'

class NupackTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Nupack::VERSION
  end

  	describe "correctly estimates examples" do
		it "Input 1" do
			assert_equal 1591.58, Estimate.new("$1299.99", "3 people", "food").price
		end

		it "Input 2" do
	      assert_equal 6199.81, Estimate.new("$5432.00", "1 person", "drugs").price
	    end

	    it "Input 3" do
	      assert_equal 13707.63, Estimate.new("$12456.95", "4 people", "books").price
	    end
	end
end
