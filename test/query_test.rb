require "minitest/autorun"
require_relative "../lib/api_bridge.rb"

class QueryTest < Minitest::Test

  def setup
    @fake_url = "http://something.unl.edu"
    @api = ApiBridge::Query.new(@fake_url)
  end

  def test_create_items_url
    # basic
    url = @api.create_items_url()
    assert_equal url, "#{@fake_url}/items?"

    # with f[] and q
    opts = { "f" => ["thing1", "thing2"], "q" => "water" }
    url = @api.create_items_url(opts)
    assert_equal url, "#{@fake_url}/items?f[]=thing1&f[]=thing2&q=water"

    # with f[], facet[], start, and num
    opts = {
      "f" => ["subcategory|works"],
      "facet" => ["title", "name"],
      "start" => 21, "num" => 20
    }
    url = @api.create_items_url(opts)
    assert_equal url, "#{@fake_url}/items?f[]=subcategory%7Cworks&facet[]=title&facet[]=name&start=21&num=20"

    # with nested f[]
    opts = { "f" => ["creator.name|Willa, Cather"] }
    url = @api.create_items_url(opts)
    assert_equal url, "#{@fake_url}/items?f[]=creator.name%7CWilla,%20Cather"

    # with multiple sorts
    opts = { "sort" => ["title|asc", "name|desc"] }
    url = @api.create_items_url(opts)
    assert_equal url, "#{@fake_url}/items?sort[]=title%7Casc&sort[]=name%7Cdesc"
  end

  def test_reset_options
    # set to something else
    @api.options = {}
    assert_equal @api.options, {}
    @api.reset_options
    assert_equal @api.options, ApiBridge::Query.class_variable_get("@@default_options")
  end

end
