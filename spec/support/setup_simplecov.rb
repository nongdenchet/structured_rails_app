if ENV['COVERAGE']
  require 'simplecov'
  require 'coveralls'

  if ENV['CIRCLE_ARTIFACTS']
    dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
    SimpleCov.coverage_dir(dir)
  end

  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
  SimpleCov.start :rails do
    filters.clear
    add_filter do |src|
      !(src.filename =~ /^#{SimpleCov.root}/) unless src.filename =~ /app/
    end
  end
end
