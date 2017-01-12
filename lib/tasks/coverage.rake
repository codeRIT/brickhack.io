namespace :coverage do
  desc "Generage code coverage via simplecov"
  task run: :environment do
    ENV["RUN_COVERAGE"] = "manual"
    Rake::Task["test"].execute
  end

  desc "Submit code coverage report to external services"
  task report: :environment do
    require 'simplecov'
    require 'codeclimate-test-reporter'
    CodeClimate::TestReporter::Formatter.new.format(SimpleCov.result)
  end
end
