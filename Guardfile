# More info at https://github.com/guard/guard#readme

guard :minitest, spring: true, all_on_start: false, all_after_pass: false do
  watch(%r{^app/(?:models|presenters|validators|lib)/(.+)\.rb$})  { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r{^app/helpers/(.+)\.rb$})                    { |m| "test/unit/helpers/#{m[1]}_test.rb" }
  watch(%r{^app/mailers/(.+)\.rb$})                    { |m| "test/functional/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/(?:([^\/]+/))?(.+)\.rb$})  { |m| "test/functional/#{m[1..2].join}_test.rb" }
  watch(%r{^app/views/(?:([^\/]+/))?([^\/]+)/.+$})     { |m| "test/functional/#{m[1..2].join}_controller_test.rb" }
  watch(%r{^app/views/layouts/.+$})                    { "test/functional" }
  watch(%r{^app/views/.+\.rb$})                        { "test/integration" }
  watch(%r{^test/.+_test.rb$})
  watch('app/controllers/application_controller.rb')   { ["test/functional", "test/integration"] }
  watch('test/test_helper.rb')                         { "test" }
end
