STATIC_DATA = {}

Dir["#{Rails.root}/config/data/**/*.yml"].each do |file|
  basename = File.basename(file, ".yml")
  STATIC_DATA[basename] = YAML.load_file(file)
end
