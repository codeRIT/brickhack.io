# -*- encoding: utf-8 -*-
# stub: paperclip-googledrive 0.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "paperclip-googledrive"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["evinsou"]
  s.date = "2016-01-09"
  s.description = "paperclip-googledrive extends paperclip support of storage for google drive storage"
  s.email = ["evinsou@gmail.com"]
  s.files = ["LICENSE", "README.md", "lib/paperclip", "lib/paperclip-googledrive.rb", "lib/paperclip/google_drive", "lib/paperclip/google_drive.rb", "lib/paperclip/google_drive/railtie.rb", "lib/paperclip/google_drive/rake.rb", "lib/paperclip/google_drive/tasks.rake", "lib/paperclip/storage", "lib/paperclip/storage/google_drive.rb", "lib/paperclip/version.rb", "paperclip-googledrive.gemspec"]
  s.homepage = "https://github.com/evinsou/paperclip-googledrive"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.4.5.1"
  s.summary = "Extends Paperclip with Google Drive storage"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<paperclip>, ["~> 4.2"])
      s.add_runtime_dependency(%q<google-api-client>, ["~> 0.8"])
      s.add_development_dependency(%q<rake>, [">= 0.9"])
    else
      s.add_dependency(%q<paperclip>, ["~> 4.2"])
      s.add_dependency(%q<google-api-client>, ["~> 0.8"])
      s.add_dependency(%q<rake>, [">= 0.9"])
    end
  else
    s.add_dependency(%q<paperclip>, ["~> 4.2"])
    s.add_dependency(%q<google-api-client>, ["~> 0.8"])
    s.add_dependency(%q<rake>, [">= 0.9"])
  end
end
