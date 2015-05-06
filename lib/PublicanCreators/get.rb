# Get-Module for PublicanCreators
# It gets the title and the informations from the configuration file
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

require 'parseconfig'
require 'dir'

# This method provides methods for user inputs
module PublicanCreatorsGet

  # THis method ask for the title, environment, type and optional settings. It returns the title variable.
  # Description:
  # @param titlein [String] will be got from the yad input.
  # @param titlechomp [String] is the cleaned title.
  # @param title [String] is the splitted input from yad.
  def self.title
    # Put the yad input as variable titlein
    titlein = `yad --title="Create documentation" --center --on-top --form --item-separator=, --separator=" "  --field="Environment:CBE" --field="Type:CBE" --field="Optional:CBE" --field="Enter a title name (with underscores instead of blanks and without umlauts):TEXT" --button="Go!" "Work,Private" "Article,Book" "Normal,Report,Homework"`
    # Format: Work/Privat!Article/Buch!title!Normal/Report/Homework
    # Cleanup the array
    titlechomp = titlein.chomp
    # Split the variable to the array title[*]
    title = titlechomp.split(' ')
    return title
  end

  # The method gets configuration from a config file
  def self.config
    home = Dir.home
    config = ParseConfig.new("#{home}/.publicancreators.cfg")
    name = config['name']
    email_private = config['email_private']
    language = config['language']
    use_brand = config['use_brand']
    title_logo = config['title_logo']
    legal = config['legal']
    brand = config['brand']
    company_name = config['company_name']
    company_division = config['company_division']
    email_business = config['email_business']
    brand_dir = config['brand_dir']
    globalentities = config['globalentities']
    articles_dir = config['articles_dir']
    reports_dir = config['reports_dir']
    books_dir = config['books_dir']
    articles_dir_priv = config['articles_dir_priv']
    homework_dir = config['homework_dir']
    books_dir_priv = config['books_dir_priv']
    brand_private = config['brand_private']
    brand_homework = config['brand_homework']
    db5 = config['db5']
    [name, email_private, language, use_brand, title_logo, legal, brand, company_name, company_division, email_business, brand_dir, globalentities, articles_dir, reports_dir, books_dir, articles_dir_priv, homework_dir, books_dir_priv, brand_private, brand_homework, db5]
  end
end