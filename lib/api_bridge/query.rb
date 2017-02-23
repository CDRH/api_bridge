require 'json'
require 'rest-client'

module ApiBridge

  class Query
    attr_accessor :url
    attr_accessor :facet_fields
    # TODO not sure that these need to be accessible
    attr_accessor :options

    @@all_options = %w(q, f, facet, hl, min, num, q, sort, page, start, facet_sort)

    @@default_options = {
      "num" => 50,
      "start" => 0
    }

    def initialize(url, facets=[], options={})
      if ApiBridge.is_url?(url)
        @url = url
        # defaults
        @facet_fields = facets
        @options = set_default_options(options)
      else
        raise "Provided URL must be valid! #{url}"
      end
    end

    def create_url(options={})
      query_string = options.map { |k, v| "#{k}=#{v}" }.join("&")
      url = "#{@url}/items?#{query_string}"
      if ApiBridge.is_url?(url)
        return url
      else
        raise "Invalid URL created for query: #{url}"
      end
    end

    def get_facets(facets=[])
      # TODO should make it easy to retrieve the facets ONLY
      # by overriding some things here, like page / num / etc
    end

    def get_item_by_id(id)
      # TODO should make it very easy to get a single item back
    end

    def reset_options
      @options = @@default_options
    end

    # overrides the CURRENTLY SET options, not the vanilla default options
    def set_default_options(options)
      @options = ApiBridge.override_options(@options, options)
    end

    def query(options={})
      puts "receiving: #{options}"
      options = _prepare_options(options)
      puts "afer preparing #{options}"
      # override defaults with requested options
      req_params = ApiBridge.override_options(@options, options)
      # create and send the request
      url = create_url(req_params)
      res = send_request(url)
      # return response format
      return ApiBridge::Response.new(res, url, req_params)
    end

    def send_request(url)
      begin
        res = RestClient.get(url)
        return JSON.parse(res.body)
      rescue => e
        raise "Something went wrong with request to #{url}: #{e.inspect}"
      end
    end

    private

    def _calc_start(options)
      # if start is specified by user then don't override with page
      page = ApiBridge.set_page(options["page"])
      # remove page from options
      options.delete("page")
      if !options.has_key?("start")
        # use the page and rows to set a start
        rows = options.has_key?("rows") ? options["rows"].to_i : @options["rows"].to_i
        options["start"] = ApiBridge.get_start(page, rows)
      end
      return options
    end

    def _prepare_options(options)
      opts = ApiBridge.clone_and_stringify_options(options)
      # remove page and replace with start
      opts = _calc_start(opts)
      # add escapes for special characters
      opts = ApiBridge.escape_values(opts)
      return opts
    end

  end  # end of Query class
end  # end of ApiBridge module
