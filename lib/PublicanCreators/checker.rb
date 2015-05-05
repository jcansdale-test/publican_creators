# Checker Module for PublicanCreators
# It checks if a directory is present. Otherwise it creates one.
#
# Copyright (C) 2015  Sascha Manns <Sascha.Manns@xcom.de>
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

# Module for directory doings
module Checker

  # Checks if the targetdirectory are present. If not, it creates one. It returns a success or fail.
  def self.check_dir(todo)
    # Checking if dir exists
    if Dir.exist?(todo)
      puts 'Found directory. Im using it.'
    else
      puts 'No directory found. Im creating it.'
      # Creates the new directory
      FileUtils.mkdir_p(todo)
      if Dir.exist?(todo)
        puts 'Created new directory...'
      else
        raise('Cant create directory')
      end
    end
  end

end