# More info at https://github.com/guard/guard#readme
guard :minitest, all_on_start: false, all_after_pass: false, spring: "bin/rails test" do
  watch(%r{^app/(?:models|presenters|validators|lib)/(.+)\.rb$}) { |m| "test/models/#{m[1]}_test.rb" }
  watch(%r{^app/helpers/(.+)\.rb$})                              { |m| "test/models/helpers/#{m[1]}_test.rb" }
  watch(%r{^app/mailers/(.+)\.rb$})                              { |m| "test/controllers/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/(.+)\.rb$})                          { |m| "test/controllers/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)\/.+$})                                { |m| "test/controllers/#{m[1]}_controller_test.rb" }
  watch(%r{^app/views/layouts/.+$})                              { "test/controllers" }
  watch(%r{^app/views/.+\.rb$})                                  { "test/integration" }
  watch(%r{^test/.+_test.rb$})
  watch('app/controllers/application_controller.rb')             { ["test/controllers", "test/integration"] }
  watch('test/test_helper.rb')                                   { "test" }
end
