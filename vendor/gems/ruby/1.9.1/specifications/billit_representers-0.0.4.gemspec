# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "billit_representers"
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcel Augsburger"]
  s.date = "2013-04-01"
  s.description = "Representers for the bill-it module of the Poplus project. These provide object-like access to remote data, using Resource-Oriented Architectures in Ruby (ROAR)."
  s.email = "devteam@ciudadanointeligente.org"
  s.homepage = "https://github.com/ciudadanointeligente/billit_representers"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Representers for the bill-it module of the Poplus project."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<roar>, [">= 0"])
    else
      s.add_dependency(%q<roar>, [">= 0"])
    end
  else
    s.add_dependency(%q<roar>, [">= 0"])
  end
end
