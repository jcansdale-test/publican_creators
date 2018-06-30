# Copyright (C) 2013-2018 Sascha Manns <Sascha.Manns@outlook.de>
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
require_relative 'change'
require_relative 'get'

# A class for creating a revison to a publican project
class RevisionCreator
  # @note Ask for the revision information
  # rubocop:disable Layout/UselessAssignment
  null, directory, member1, member2, member3, member4, member5, revnumber = PublicanCreatorsGet.revision
  language = PublicanCreatorsGet.config_revision

  revision, edition = revnumber.split('-')

  # This method prepares the string for adding a new revision
  # @param [String] member1 is the first string into revdescription
  # @param [String] member2 is the second string into revdescription
  # @param [String] member3 is the third string into revdescription
  # @param [String] member4 is the fourth string into revdescription
  # @param [String] member5 is the fifth string into revdescription
  # @param [String] revnumber is the revision number
  # @param [String] language is the language. Comes from config file.
  # @return [String] string is that string for creating the commit
  def self.prepare_revision(member1, member2, member3, member4, member5, revnumber, language)
    string = "--member \"#{member1}\""
    string << " --member \"#{member2}\"" if member2 != ''
    string << " --member \"#{member3}\"" if member3 != ''
    string << " --member \"#{member4}\"" if member4 != ''
    string << " --member \"#{member5}\"" if member5 != ''
    string << " --revnumber \"#{revnumber}\""
    string << " --lang \"#{language}\""
  end

  # This method changes to the target directory
  FileUtils.cd(directory) do
    string = prepare_revision(member1, member2, member3, member4, member5, revnumber, language)
    PublicanCreatorsChange.replace_productnumber(revision, edition, language)
    system("publican add_revision #{string}")
  end
end
