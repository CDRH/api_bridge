module ApiBridge

  class Response
    attr_reader :req_opts
    attr_reader :req_url
    attr_reader :res

    def initialize(res, url, options)
      @req_opts = options
      @req_url = url
      @res = res
    end

    def count
      @res.dig("res", "count")
    end

    def facets
      @res.dig("res", "facets")
    end

    def items
      @res.dig("res", "items")
    end

    def first
      @res.dig("res", "items", 0)
    end

    def pages
      if self.count
        return (self.count.to_f/@req_opts["rows"]).ceil
      else
        return 0
      end
    end
  end

end
