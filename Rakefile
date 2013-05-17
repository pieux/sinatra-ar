require 'rubygems'

def get_env name, default=nil
  ENV[name] || ENV[name.downcase] || default
end

task :default => :test
task :test => :spec

# RSpec built-in rake task
require 'rspec/core/rake_task'
desc 'Run all examples'
RSpec::Core::RakeTask.new(:spec) do |t|
  #t.pattern = 'spec/**/*_spec.rb' # not needed this is default
  t.rspec_opts = %w(-cfs)
end

# sinatra-activerecord built-in rake task
require "sinatra/activerecord/rake"

# __END__
# some notes for this file
# 1. Bundler.require vs. Bundler.setup
# 1) Bundler.setup 会修改 $LOAD_PATH, 在没有 Bundler 之前, 使用 require 'rubygems', 这时候就是 require 'bundler/setup'
# 2) Bundler.require 会 require group 里的gem. 相当于一系列的 require 'gem'.
