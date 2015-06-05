# PublicanCreatorsGet
# @author Sascha Manns
# @abstract Class for gathering information from config file and user input
#
# Copyright (C) 2015  Sascha Manns <Sascha-Manns@web.de>
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

require 'parseconfig'
require 'dir'

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
on http://saigkill.ddns.net:8112/dashboard:LBL" --button="Go!" "Work,Private" \
"Article,Book" "Normal,Report,Homework"`
    # @note Format: Work/Private Article/Book title!Normal Report Homework
    # @note Cleanup the array
    environment, type, opt, titlefix = titlein.chomp.split('|')

    # @note replace blanks with underscores
    title = titlefix.gsub(/ /, '_')

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
    home = Dir.home
    config = ParseConfig.new("#{home}/.publicancreators.cfg")
    language = config['language']
    puts language
  end
end
