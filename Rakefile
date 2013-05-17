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
# require "sinatra/activerecord/rake"

# ActiveRecord tasks
require 'active_record'
namespace :db do
  desc "prepare environment (utility)"
  task :env do
    require 'bundler'
    env = get_env 'RACK_ENV', 'development'
    Bundler.require :default, env.to_sym
    unless defined?(DB_CONFIG)
      databases = YAML.load_file File.dirname(__FILE__) + '/config/database.yml'
      DB_CONFIG = databases[env]
    end
    puts "loaded config for #{env}"
  end

  desc "connect db (utility)"
  task connect: :env do
    "connecting to #{DB_CONFIG['database']}"
    ActiveRecord::Base.establish_connection DB_CONFIG
  end

  desc "create db for current RACK_ENV"
  task create: :env do
    puts "creating db #{DB_CONFIG['database']}"
    ActiveRecord::Base.establish_connection DB_CONFIG.merge('database' => nil)
    ActiveRecord::Base.connection.create_database DB_CONFIG['database'], charset: 'utf8'
    ActiveRecord::Base.establish_connection DB_CONFIG
  end

  desc 'drop db for current RACK_ENV'
  task drop: :env do
    if get_env('RACK_ENV') == 'production'
      puts "cannot drop production database!"
    else
      puts "dropping db #{DB_CONFIG['database']}"
      ActiveRecord::Base.establish_connection DB_CONFIG.merge('database' => nil)
      ActiveRecord::Base.connection.drop_database DB_CONFIG['database']
    end
  end

  # desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  # task :migrate do
  #   ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )

  desc 'run migrations'
  task migrate: :connect do
    version = get_env 'VERSION'
    version = version ? version.to_i : nil
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate 'db/migrate', version
  end

  desc 'rollback migrations (STEP = 1 by default)'
  task rollback: :connect do
    step = get_env 'STEP'
    step = step ? step.to_i : 1
    ActiveRecord::Migrator.rollback 'db/migrate', step
  end

  desc "show current schema version"
  task version: :connect do
    puts ActiveRecord::Migrator.current_version
  end
end

# __END__
# some notes for this file
# 1. Bundler.require vs. Bundler.setup
# 1) Bundler.setup 会修改 $LOAD_PATH, 在没有 Bundler 之前, 使用 require 'rubygems', 这时候就是 require 'bundler/setup'
# 2) Bundler.require 会 require group 里的gem. 相当于一系列的 require 'gem'.
