Gem::Specification.new do |gem|
  gem.name     = "restful_jsonp"
  gem.version  = "2.1.1"
  gem.authors  = ["Matt Zukowski", "James Richard"]
  gem.email    = ["hebo@cuddlyzombie.com"]
  gem.homepage = "http://github.com/Hebo/restful_jsonp"
  gem.summary  = "Makes your RESTful Rails service accessible using JSONP. Use the '_method' parameter in your requests to specify the request method."
  gem.description = "Normally Rails/Rack only checks the '_method' parameter in POST requests, but JSONP requests are always GETs. This railtie enables the '_method' check for all request types, including GET."
  gem.require_paths = ["lib"]

  gem.files = `git ls-files`.split("\n")

  gem.add_dependency "rack", "~> 1"
  gem.add_dependency "rails"
end
