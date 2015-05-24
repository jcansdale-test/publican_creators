# PublicanCreatorsChecker
# @author Sascha Manns
# @abstract Class for checking directories and creating them
#
# Copyright (C) 2015  Sascha Manns <Sascha.Manns@bdvb.de>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:#
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Dependencies

require 'dir'
require 'fileutils'
require 'rainbow/ext/string'

# Module for different checks
module Checker

  # Checks if the targetdirectory are present. If not, it creates one. It returns a success or fail.
  # @param [String] todos contains the target directory
  # @return [String] true or false
  def self.check_dir(todos)
    # @note Checking if dir exists
    if Dir.exist?(todos)
      puts 'Found directory. Im using it.'.color(:green)
    else
      puts 'No directory found. Im creating it.'.color(:red)
      # @note Creates the new directory
      FileUtils.mkdir_p(todos)
      if Dir.exist?(todos)
        puts 'Created new directory...'.color(:green)
      else
        raise('Cant create directory').color(:red)
      end
    end
  end
end