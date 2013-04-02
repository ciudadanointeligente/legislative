# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "roar"
  s.version = "0.11.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nick Sutterer"]
  s.date = "2012-06-22"
  s.description = "Streamlines the development of RESTful, resource-oriented architectures in Ruby."
  s.email = ["apotonick@gmail.com"]
  s.homepage = "http://rubygems.org/gems/roar"
  s.require_paths = ["lib"]
  s.rubyforge_project = "roar"
  s.rubygems_version = "1.8.25"
  s.summary = "Resource-oriented architectures in Ruby."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<representable>, [">= 1.2.2"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test_xml>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 2.8.1"])
    else
      s.add_dependency(%q<representable>, [">= 1.2.2"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test_xml>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 2.8.1"])
    end
  else
    s.add_dependency(%q<representable>, [">= 1.2.2"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test_xml>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 2.8.1"])
  end
end
