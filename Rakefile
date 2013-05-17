require 'rubygems'
# require 'bundler/setup'
require 'rspec/core/rake_task'

task :default => :test
task :test => :spec

unless defined?(RSpec)
  puts 'spec targets require RSpec'
else
  desc 'Run all examples'
  RSpec::Core::RakeTask.new(:spec) do |t|
    #t.pattern = 'spec/**/*_spec.rb' # not needed this is default
    t.rspec_opts = %w(-cfs)
  end
end
