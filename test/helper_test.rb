require "minitest/autorun"
require_relative "../lib/api_bridge.rb"

class HelperTest < Minitest::Test

  def test_calculate_page
    assert_equal ApiBridge.calculate_page(101, 20), 6
    assert_equal ApiBridge.calculate_page(1, 20), 1
    assert_equal ApiBridge.calculate_page(9, 3), 3
    assert_equal ApiBridge.calculate_page(57, 5), 12
  end

  def test_encode
    fake_url = "http://something.unl.edu/?param="

    assert_equal "#{fake_url}Cather%3B+Pound",
      ApiBridge.encode("#{fake_url}Cather; Pound")
    assert_equal "#{fake_url}Cather%2C+Pound",
      ApiBridge.encode("#{fake_url}Cather, Pound")
  end

  def test_escape_values
    # pending
  end

  def test_get_start
    assert_equal ApiBridge.get_start(10, 20), 180
    assert_equal ApiBridge.get_start(1, 20), 0
  end

  def test_clone_and_stringify_options
    # TODO
  end

  def test_is_url?
    assert ApiBridge.is_url?("http://unl.edu?some=thing&something=else")
    refute ApiBridge.is_url?("localhost:8983")
    assert ApiBridge.is_url?("http://localhost:8983")
  end

  def test_override_options

  end

end
