# Copyright (C) 2013-2019 Sascha Manns <Sascha.Manns@outlook.de>
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

require 'parseconfig'
require 'xdg'

# This method provides methods for user inputs
module PublicanCreatorsGet
  # This method ask for the title, environment, type and optional settings.
  # It returns the title variable.
  # @return [String] environment, type, opt, title
  def self.title
    # @note Put the yad input as variable titlein
    titlein = `yad --title="Create documentation" --center --on-top --form \
--item-separator=, --separator="|"  --field="Environment:CBE" \
--field="Type:CBE" --field="Optional:CBE" --field="Enter a title name \
(with underscores instead of blanks and without umlauts):TEXT" \
--field="Please file bugs or feature requests \
on https://bugs.launchpad.net/publicancreators:LBL" --button="Go!" "Work,Private" \
"Article,Book" "Normal,Report,Homework"`
    # @note Format: Work/Private Article/Book title!Normal Report Homework
    # @note Cleanup the array
    environment, type, opt, titlefix = titlein.chomp.split('|')

    # @note replace blanks with underscores
    title = titlefix.tr(' ', '_')

    [environment, type, opt, title]
  end

  # This method ask for revision information
  # Description:
  # @return [String] revision
  def self.revision
    # @note Put the yad input as variable revhistin
    revhistin = `yad --title="Create Revision" --center --on-top --form \
--item-separator=, --separator="|" --field="Choose the directory where your \
project publican.cfg is:LBL" --field="Projectdir:DIR" --field="Enter your \
first revision text:TEXT" --field="Enter your second revision text:TEXT" \
--field="Enter your third revision text:TEXT" --field="Enter your fourth \
revision text:TEXT" --field="Enter your fifth revision text:TEXT" \
--field="Enter Revision number:TEXT" --field="You can use backslashes for \
entering Revision textes with blanks.:LBL" --button="Go!"`
    # @note Format: Directory|One|Two|Three|Four|Five|Revision
    # @note Cleanup the array
    revision = revhistin.chomp.split('|')
    # @note Split the variable to array revision[*]
    puts revision
  end

  # This method gets the language from the config file for using in
  # RevisionCreator
  # @return [String] language
  def self.config_revision
    include ParseConfig
    sys_xdg = XDG['CONFIG_HOME']
    config = ParseConfig.new("#{sys_xdg}/publican_creators/publicancreators.cfg")
    language = config['language']
    puts language
  end
end
