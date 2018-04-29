# Copyright (C) 2013-2018 Sascha Manns <Sascha.Manns@mailbox.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
