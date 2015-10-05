require 'test_helper'

class NupackTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Nupack::VERSION
  end

  	describe "correctly estimates examples" do
		it "Input 1" do
			assert_equal "$1591.58", Estimate.new("$1299.99", "3 people", "food").price
		end

		it "Input 2" do
	      assert_equal "$6199.81", Estimate.new("$5432.00", "1 person", "drugs").price
	    end

	    it "Input 3" do
	      assert_equal "$13707.63", Estimate.new("$12456.95", "4 people", "books").price
	    end
	end

	describe "handles invalid inputs" do
		it "invalid value input" do
			err1 = assert_raises {Estimate.new("a", "3 people", "food").price}
			err2 = assert_raises {Estimate.new("$", "3 people", "food").price}
			err3 = assert_raises {Estimate.new("", "3 people", "food").price}
			err4 = assert_raises {Estimate.new("$12ab93.34", "3 people", "food").price}
			err5 = assert_raises {Estimate.new("&12.34", "3 people", "food").price}

			assert_equal "Invalid value input!", err1.message
			assert_equal "Invalid value input!", err2.message
			assert_equal "Invalid value input!", err3.message
			assert_equal "Invalid value input!", err4.message
			assert_equal "Invalid value input!", err5.message
		end

		it "invalid person input" do
			err1 = assert_raises {Estimate.new("$12.34", "people", "food").price}
			assert_equal "Invalid person input!", err1.message
		end
	end

	describe "markups return correct values" do
		it "returns flat markup" do
			assert_equal "$105.00", Estimate.new("$100.00", "0 people", "n/a").price
		end

		it "returns people markup" do
			assert_equal "$106.26", Estimate.new("$100.00", "1 people", "n/a").price
			assert_equal "$117.60", Estimate.new("$100.00", "10 people", "n/a").price
		end

		it "returns material markup" do
			assert_equal "$112.88", Estimate.new("$100.00", "0 people", "drugs").price
			assert_equal "$118.65", Estimate.new("$100.00", "0 people", "food").price
			assert_equal "$107.10", Estimate.new("$100.00", "0 people", "electric").price
			assert_equal "$105.00", Estimate.new("$100.00", "0 people", "other??").price
		end
	end
end
