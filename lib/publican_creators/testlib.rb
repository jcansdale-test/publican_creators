# Testing Module for PublicanCreators
# PublicanCreatorsChange
# @author Sascha Manns
# @abstract Class for all file changes
#
# Copyright (C) 2015-2017  Sascha Manns <Sascha.Manns@mailbox.org>
# License: MIT

# Dependencies
require 'fileutils'

# Class for methods in testing environment
class PublicanCreatorsTest
  # Method for checking file content
  # @param [String] file can be any file
  # @param [String] pattern is the searchpattern
  # @return [String] result
  def self.check_content(file, pattern)
    f = File.new(file)
    text = f.read
    result = 'false' # Default false
    result = 'true' if text =~ /"#{pattern}"/ # if found true
    return result
  end

  # Method for cleanup the test results
  def self.cleanup
    system('rm -rf The_holy_Bible*')
  end
end
