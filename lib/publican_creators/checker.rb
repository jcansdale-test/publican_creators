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
require 'rainbow/ext/string'

# Module for different checks
module Checker
  # Checks if the targetdirectory are present. If not, it creates one. It
  # returns a success or fail.
  # @param [String] todos contains the target directory
  # @return [String] true or false
  def self.check_dir(todos)
    # @note Checking if dir exists
    # TODO: Try to fix this in future
    # rubocop:disable Style/GuardClause
    if Dir.exist?(todos)
      puts 'Found directory. Im using it.'
    else
      puts 'No directory found. Im creating it.'
      # @note Creates the new directory
      FileUtils.mkdir_p(todos)
      if Dir.exist?(todos)
        puts 'Created new directory...'
      else
        raise('Cant create directory')
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
      raise('Cant create documentation. Please try it manual with publican...')
    end
  end
end
