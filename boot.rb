require 'rubygems'

# Set rack environment
ENV['RACK_ENV'] ||= "development"

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'sinatra'
require 'sinatra/reloader' if development?

# Set project configuration
require File.expand_path("../application", __FILE__)

# __END__

# some notes for this file
#
# 1. what is ENV?
# ENV is a hash-like accessor for environment variables.
# 具体什么作用不清楚, 但是, 应该类似于全局变量的存储器吧.
# 取名应该不是强制性的, 或许是约定?
#
# 2. File.expand_path('../Gemfile', __FILE__)
# File.expand_path(file_name, [,dir_string])
# 获得路径名的绝对路径形式
# 注意这里的参数 file_name, 是指 pathname
# 如果不指定 dir_string, 则是当前工作目录, 和__FILE__的功能同
#
# 3. require 'bundler/setup'
# 这一句的目的很简单, 使用Gemfile中定义的gem, 而不是其他,
# 比如 GEM_HOME, GEM_PATH 之类, 不过我不会查看这些环境变量
# 顺便说下, 查看 $LOAD_PATH, ruby -e 'puts $LOAD_PAHT'
# $LOAD_PATH 简写 $:
#
# 4. require 'rubygems' ?
# 为什么要有这一行?
# 暂时不知道. 好像也是修改 $LOAD_PATH
# http://docs.rubygems.org/read/chapter/3#page70
