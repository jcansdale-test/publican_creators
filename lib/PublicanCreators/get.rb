# PublicanCreatorsGet
# @author Sascha Manns
# @abstract Class for gathering information from config file and user input
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: GPL-3

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
