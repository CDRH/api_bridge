# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_bridge/version'

Gem::Specification.new do |spec|
  spec.name          = "api_bridge"
  spec.version       = ApiBridge::VERSION
  spec.authors       = ["Jessica Dussault (jduss4)", "Greg Tunink (techgique)"]
  spec.email         = ["jdussault@unl.edu", "techgique@unl.edu"]
  spec.summary       = %q{Connects CDRH rails sites to CDRH API}
  spec.description   = %q{The Center for Digital Research in the Humanities 
                          (CDRH) has marked up many documents with TEI, Dublin Core,
                          VRA, and other encoding standards. These documents are indexed
                          into an API. This gem reduces repeating logic when powering sites
                          with the API's information.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.7"
  spec.add_dependency "rake", "~> 11.3"
  spec.add_dependency "rest-client"

  spec.add_development_dependency "minitest", "~> 5.10"
end
