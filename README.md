# ApiBridge

The Center for Digital Research in the Humanities (CDRH) has marked up many documents with TEI, Dublin Core, VRA, and other encoding standards. These documents are indexed into an API. This gem reduces repeating logic when powering sites with the API's information.

## Local Development

To work on and test this gem locally, run the following:

```
gem build name.gemspec
rake install
# or gem install /path/to/gem/pkg/api_bridge-0.1.0.gem
```

Then in a project's gemfile:

```
gem 'name', :path => 'path/to/gem'
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'api_bridge', :git => 'git://github.com/CDRH/api_bridge.git'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install api_bridge

## Usage

### Quick Start
Require the gem at the top of your file and create a new instance with the url to your solr core and, optionally, any fields you wish to set as default facets.

```ruby
require 'api_bridge'

url = "http://thing.unl.edu:port/path_to_core
solr = ApiBridge::Query.new(url, ["title", "category", "author"], { "options" = "like_this" })
```

Run your first request to return all objects!
```ruby
res = solr.query
puts res.class
 => ApiBridge::Response
puts res.count
 => 83
puts res.pages
 => 2
puts res.items
 => # array of api results
```

## TODO

- write tests to guarantee that all the options are being overridden correctly and uri expected
- look into encoding characters like : \s etc
- write documentation about how to query with overrides, pagination, etc
