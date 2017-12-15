static_data = {}
Dir["#{Rails.root}/config/data/**/*.yml"].each do |file|
  basename = File.basename(file, ".yml")
  static_data[basename] = YAML.load_file(file)
end

STATIC_DATA = static_data.freeze
