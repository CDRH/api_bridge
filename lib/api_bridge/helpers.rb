require 'uri'

module ApiBridge

  def self.encode_html(string)
    return URI.encode(string)
  end

  def self.escape_values(options)
    # TODO what kind of escaping or sanitizing do we
    # want to do here?
    return options
  end

  def self.get_start(page, rows)
    return (page - 1) * rows
  end

  def self.clone_and_stringify_options(aOpts)
    # if params are already a hash, leave them alone,
    # otherwise assume they are Rails parameters and convert to hash
    opts_hash = {}
    if aOpts.class == Hash
      opts_hash = aOpts.clone
    elsif aOpts.class == ActionController::Parameters
      # only allow through "safe" params and convert to hash
      opts_hash = aOpts.to_unsafe_h
    end
    # ensure that there are no symbols hiding in there
    return Hash[opts_hash.map { |k, v| [k.to_s, v] }]
  end

  def self.is_url?(url)
    # rely on uri gem to do the heavy lifting
    result = url =~ /\A#{URI::Parser.new.make_regexp(['http', 'https'])}\z/
    # convert to boolean
    return !!result
  end

  def self.override_options(existing, requested)
    existing = clone_and_stringify_options(existing)
    requested = clone_and_stringify_options(requested)
    # if existing and requested share a key, requested will triumph
    return existing.merge(requested)
  end

  def self.set_page(page)
    new_page = 1
    if !page.nil?
      is_pos_num = /\A\d+\z/.match(page)
      if is_pos_num
        new_page = page.to_i
      end
    end
    return new_page
  end
end
