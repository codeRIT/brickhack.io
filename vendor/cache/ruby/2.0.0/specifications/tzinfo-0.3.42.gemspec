# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "tzinfo"
  s.version = "0.3.42"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Philip Ross"]
  s.date = "2014-10-22"
  s.description = "TZInfo is a Ruby library that uses the standard tz (Olson) database to provide daylight savings aware transformations between times in different time zones."
  s.email = "phil.ross@gmail.com"
  s.extra_rdoc_files = ["README", "CHANGES"]
  s.files = ["README", "CHANGES"]
  s.homepage = "http://tzinfo.github.io"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--exclude", "definitions", "--exclude", "indexes"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "tzinfo"
  s.rubygems_version = "2.0.2"
  s.summary = "Daylight-savings aware timezone library"
end
