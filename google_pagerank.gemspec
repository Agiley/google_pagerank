# -*- encoding: utf-8 -*-
# stub: google_pagerank 0.0.10 ruby lib

Gem::Specification.new do |s|
  s.name = "google_pagerank"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Sebastian Johnsson"]
  s.date = "2012-01-26"
  s.description = "API for fetching Google Pagerank"
  s.email = "sebastian@agiley.se"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = [".rspec", "Gemfile", "README.rdoc", "Rakefile", "VERSION", "google_pagerank.gemspec", "lib/google/pagerank/constants.rb", "lib/google/pagerank/client.rb", "lib/google_pagerank.rb", "lib/tasks/google_pagerank_tasks.rake", "spec/google_pagerank/client_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/Agiley/google_pagerank"
  s.rubygems_version = "2.4.5"
  s.summary = "API for fetching Google Pagerank"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, [">= 0.9"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<faraday>, [">= 0.9"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<faraday>, [">= 0.9"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
