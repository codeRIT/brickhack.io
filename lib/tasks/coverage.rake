namespace :coverage do
  desc "Generage code coverage via simplecov"
  task :run => :environment do
    ENV["RUN_COVERAGE"] = "1"
    Rake::Task["test"].execute
  end

end
