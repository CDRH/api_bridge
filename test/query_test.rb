require "minitest/autorun"
require_relative "../lib/api_bridge.rb"

class QueryTest < Minitest::Test
  def setup
    @api = ApiBridge::Query.new("http://some.url")
  end
  def test_create_url
    url1 = @api.create_url({})
    assert_equal url1, "http://some.url/items?"

    url2 = @api.create_url({"f" => ["thing1", "thing2"], "q" => "water"})
    assert_equal url2, "http://some.url/items?f[]=thing1&f[]=thing2&q=water"

    url3 = @api.create_url({"f" => ["subcategory|works"], "facet" => ["title", "name"], "start" => 21, "num" => 20})
    assert_equal url3, "http://some.url/items?f[]=subcategory%7Cworks&facet[]=title&facet[]=name&start=21&num=20"
  end
end
