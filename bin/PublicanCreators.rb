#!/usr/bin/env ruby
begin
  require 'PublicanCreators'
rescue LoadError
  require 'rubygems'
  require 'PublicanCreators'
  require 'bundler/setup'
end
#require File.expand_path(File.join(File.dirname(__FILE__), '../lib', 'PublicanCreators.rb'))

# You can add fixtures and/or initialization code here to make experimenting
# with your gem easier. You can also use a different console, if you like.

# (If you use this, don't forget to add pry to your Gemfile!)
# require "pry"
# Pry.start

IRB.start
