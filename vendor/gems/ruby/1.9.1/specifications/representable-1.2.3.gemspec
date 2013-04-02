# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "representable"
  s.version = "1.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nick Sutterer"]
  s.date = "2012-06-09"
  s.description = "Maps representation documents from and to Ruby objects. Includes XML and JSON support, plain properties, collections and compositions."
  s.email = ["apotonick@gmail.com"]
  s.homepage = "http://representable.apotomo.de"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Maps representation documents from and to Ruby objects. Includes XML and JSON support, plain properties, collections and compositions."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test_xml>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 2.8.1"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<mongoid>, [">= 0"])
      s.add_development_dependency(%q<virtus>, ["~> 0.5.0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test_xml>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 2.8.1"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<mongoid>, [">= 0"])
      s.add_dependency(%q<virtus>, ["~> 0.5.0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test_xml>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 2.8.1"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<mongoid>, [">= 0"])
    s.add_dependency(%q<virtus>, ["~> 0.5.0"])
  end
end
