# -*- encoding: utf-8 -*-
# stub: bootswatch-rails 3.3.5 ruby lib

Gem::Specification.new do |s|
  s.name = "bootswatch-rails".freeze
  s.version = "3.3.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Maxim Chernyak".freeze, "Esteban Arango Medina".freeze]
  s.date = "2015-06-22"
  s.description = "Bootswatches converted to SCSS ready to use in Rails asset pipeline.".freeze
  s.email = ["max@bitsonnet.com".freeze, "marranoparael31@gmail.com".freeze]
  s.homepage = "http://github.com/maxim/bootswatch-rails".freeze
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Bootswatches in your Rails asset pipeline".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1"])
  end
end
