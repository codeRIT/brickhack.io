# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "pg"
  s.version = "0.17.1"
  s.platform = "x86-mingw32"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Granger", "Lars Kanis"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDaDCCAlCgAwIBAgIBATANBgkqhkiG9w0BAQUFADA9MQ4wDAYDVQQDDAVrYW5p\nczEXMBUGCgmSJomT8ixkARkWB2NvbWNhcmQxEjAQBgoJkiaJk/IsZAEZFgJkZTAe\nFw0xMzAyMjYwODQ1NTlaFw0xNDAyMjYwODQ1NTlaMD0xDjAMBgNVBAMMBWthbmlz\nMRcwFQYKCZImiZPyLGQBGRYHY29tY2FyZDESMBAGCgmSJomT8ixkARkWAmRlMIIB\nIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApop+rNmg35bzRugZ21VMGqI6\nHGzPLO4VHYncWn/xmgPU/ZMcZdfj6MzIaZJ/czXyt4eHpBk1r8QOV3gBXnRXEjVW\n9xi+EdVOkTV2/AVFKThcbTAQGiF/bT1n2M+B1GTybRzMg6hyhOJeGPqIhLfJEpxn\nlJi4+ENAVT4MpqHEAGB8yFoPC0GqiOHQsdHxQV3P3c2OZqG+yJey74QtwA2tLcLn\nQ53c63+VLGsOjODl1yPn/2ejyq8qWu6ahfTxiIlSar2UbwtaQGBDFdb2CXgEufXT\nL7oaPxlmj+Q2oLOfOnInd2Oxop59HoJCQPsg8f921J43NCQGA8VHK6paxIRDLQID\nAQABo3MwcTAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHQ4EFgQUvgTdT7fe\nx17ugO3IOsjEJwW7KP4wGwYDVR0RBBQwEoEQa2FuaXNAY29tY2FyZC5kZTAbBgNV\nHRIEFDASgRBrYW5pc0Bjb21jYXJkLmRlMA0GCSqGSIb3DQEBBQUAA4IBAQCa3ThZ\n9qjyuFXe0kN4IwgHTTSqob3zPOyXAxAq1k65w1/hI/6e4HxCSH7Ds+dKj/xhScEu\nK5gaya1D69Fo+JTnzLvuSt2X8+mEHclduC9j++oSGc+szd7LKdeEQ7J4RefJjhD+\nvWI6lqglL4PijN0nOWtm0ygzXEELDcGYpb2WJ++KKNVLIU6pkiWpZUmGcFB7NclV\nI64m9iNdgWnDwedgUlqSMfVCUUB9S1Y5jI+doxYloPvIB6+6VsI4cmN2LcK0rQO6\nN3pmmsS0N5772vAmRMyNl8PV1OzCLIMhgPgdeLpfU7LUSYWj67q5VuyjAaH5h68g\nMlGgwc//cCsBG8sa\n-----END CERTIFICATE-----\n"]
  s.date = "2013-12-19"
  s.description = "Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/].\n\nIt works with {PostgreSQL 8.4 and later}[http://www.postgresql.org/support/versioning/].\n\nA small example usage:\n\n  #!/usr/bin/env ruby\n\n  require 'pg'\n\n  # Output a table of current connections to the DB\n  conn = PG.connect( dbname: 'sales' )\n  conn.exec( \"SELECT * FROM pg_stat_activity\" ) do |result|\n    puts \"     PID | User             | Query\"\n  result.each do |row|\n      puts \" %7d | %-16s | %s \" %\n        row.values_at('procpid', 'usename', 'current_query')\n    end\n  end"
  s.email = ["ged@FaerieMUD.org", "lars@greiz-reinsdorf.de"]
  s.extra_rdoc_files = ["Contributors.rdoc", "History.rdoc", "Manifest.txt", "README-OS_X.rdoc", "README-Windows.rdoc", "README.ja.rdoc", "README.rdoc", "ext/errorcodes.txt", "POSTGRES", "LICENSE", "ext/gvl_wrappers.c", "ext/pg.c", "ext/pg_connection.c", "ext/pg_errors.c", "ext/pg_result.c"]
  s.files = ["Contributors.rdoc", "History.rdoc", "Manifest.txt", "README-OS_X.rdoc", "README-Windows.rdoc", "README.ja.rdoc", "README.rdoc", "ext/errorcodes.txt", "POSTGRES", "LICENSE", "ext/gvl_wrappers.c", "ext/pg.c", "ext/pg_connection.c", "ext/pg_errors.c", "ext/pg_result.c"]
  s.homepage = "https://bitbucket.org/ged/ruby-pg"
  s.licenses = ["BSD", "Ruby", "GPL"]
  s.rdoc_options = ["-f", "fivefish", "-t", "pg: The Ruby Interface to PostgreSQL", "-m", "README.rdoc"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = "pg"
  s.rubygems_version = "2.0.2"
  s.summary = "Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<rake-compiler>, ["~> 0.9"])
      s.add_development_dependency(%q<hoe>, ["~> 3.5.1"])
      s.add_development_dependency(%q<hoe-deveiate>, ["~> 0.2"])
      s.add_development_dependency(%q<hoe-bundler>, ["~> 1.0"])
    else
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<rake-compiler>, ["~> 0.9"])
      s.add_dependency(%q<hoe>, ["~> 3.5.1"])
      s.add_dependency(%q<hoe-deveiate>, ["~> 0.2"])
      s.add_dependency(%q<hoe-bundler>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<rake-compiler>, ["~> 0.9"])
    s.add_dependency(%q<hoe>, ["~> 3.5.1"])
    s.add_dependency(%q<hoe-deveiate>, ["~> 0.2"])
    s.add_dependency(%q<hoe-bundler>, ["~> 1.0"])
  end
end
