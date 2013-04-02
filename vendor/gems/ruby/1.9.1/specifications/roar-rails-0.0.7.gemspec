# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "roar-rails"
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nick Sutterer"]
  s.date = "2012-06-10"
  s.description = "Rails extensions for using Roar in the popular web framework."
  s.email = ["apotonick@gmail.com"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubyforge_project = "roar-rails"
  s.rubygems_version = "1.8.25"
  s.summary = "Use Roar in Rails."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<roar>, ["~> 0.10"])
      s.add_runtime_dependency(%q<test_xml>, [">= 0"])
      s.add_runtime_dependency(%q<actionpack>, ["~> 3.0"])
      s.add_runtime_dependency(%q<railties>, ["~> 3.0"])
      s.add_development_dependency(%q<minitest>, [">= 2.8.1"])
      s.add_development_dependency(%q<tzinfo>, [">= 0"])
    else
      s.add_dependency(%q<roar>, ["~> 0.10"])
      s.add_dependency(%q<test_xml>, [">= 0"])
      s.add_dependency(%q<actionpack>, ["~> 3.0"])
      s.add_dependency(%q<railties>, ["~> 3.0"])
      s.add_dependency(%q<minitest>, [">= 2.8.1"])
      s.add_dependency(%q<tzinfo>, [">= 0"])
    end
  else
    s.add_dependency(%q<roar>, ["~> 0.10"])
    s.add_dependency(%q<test_xml>, [">= 0"])
    s.add_dependency(%q<actionpack>, ["~> 3.0"])
    s.add_dependency(%q<railties>, ["~> 3.0"])
    s.add_dependency(%q<minitest>, [">= 2.8.1"])
    s.add_dependency(%q<tzinfo>, [">= 0"])
  end
end
