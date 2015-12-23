# PublicanCreatorsChecker
# @author Sascha Manns
# @abstract Class for checking directories and creating them
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies

require 'fileutils'
require 'rainbow/ext/string'

# Module for different checks
module Checker
  # Checks if the targetdirectory are present. If not, it creates one. It
  # returns a success or fail.
  # @param [String] todos contains the target directory
  # @return [String] true or false
  def self.check_dir(todos)
    # @note Checking if dir exists
    if Dir.exist?(todos)
      puts 'Found directory. Im using it.'
    else
      puts 'No directory found. Im creating it.'
      # @note Creates the new directory
      FileUtils.mkdir_p(todos)
      if Dir.exist?(todos)
        puts 'Created new directory...'
      else
        fail('Cant create directory')
      end
    end
  end

  # This method will be launched from the init_docu_* methods. It returns a
  # success, otherwise it raises with a error.
  # @param [String] title comes from the get method. This @param represents the
  # name or title of your work. It is used in all important code places.
  # @return [String] true or false
  def self.check_result(title)
    # @note checking if new documentation directory exists
    if Dir.exist?(title)
      puts 'Creating documentation was a success...'
    else
      fail('Cant create documentation. Please try it manual with publican...')
    end
  end
end
