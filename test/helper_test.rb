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
    fake_url = "http://something.unl.edu/"

    # semicolons
    assert_equal "#{fake_url}?param=Cather%3B+Pound",
      ApiBridge.encode("#{fake_url}?param=Cather; Pound")
    assert_equal "#{fake_url}?param=Cather%2C+Pound",
      ApiBridge.encode("#{fake_url}?param=Cather, Pound")
    # multiple types of characters
    assert_equal "#{fake_url}?f[]=works%7CTitle+%282012%29+Author",
      ApiBridge.encode("#{fake_url}?f[]=works|Title (2012) Author")
    # multiple parameters
    query_in = "f[]=works|Title (1827)&f[]=works|Title2, Author; Author2&q=*"
    query_out = "f[]=works%7CTitle+%281827%29&f[]=works%7CTitle2%2C+Author%3B+Author2&q=*"
    assert_equal "#{fake_url}?#{query_out}",
      ApiBridge.encode("#{fake_url}?#{query_in}")
    # no parameters
    assert_equal fake_url, ApiBridge.encode(fake_url)
  end

  def test_encode_query_params
    assert_equal "authors=Cather%3B+Pound&f[]=works%7CSomething",
      ApiBridge.encode_query_params("authors=Cather; Pound&f[]=works|Something")
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
    # TODO
  end

end
