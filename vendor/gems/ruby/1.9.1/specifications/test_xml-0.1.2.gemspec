# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "test_xml"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pavel Gabriel", "Nick Sutterer"]
  s.date = "2011-04-20"
  s.description = "Test your XML with Test::Unit, MiniTest, RSpec, or Cucumber using handy assertions like #assert_xml_equal or #assert_xml_structure_contain."
  s.email = ["alovak@gmail.com", "apotonick@gmail.com"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc"]
  s.homepage = "http://github.com/alovak/test_xml"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Test your XML with Test::Unit, MiniTest, RSpec, or Cucumber."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.3.2"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<rspec-core>, ["~> 2.2"])
    else
      s.add_dependency(%q<nokogiri>, [">= 1.3.2"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<rspec-core>, ["~> 2.2"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 1.3.2"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<rspec-core>, ["~> 2.2"])
  end
end
