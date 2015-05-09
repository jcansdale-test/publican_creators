# PublicanCreatorsGet
# @author Sascha Manns
# @abstract Class for gathering information from config file and user input
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

require 'parseconfig'
require 'dir'

# This method provides methods for user inputs
module PublicanCreatorsGet

  # This method ask for the title, environment, type and optional settings. It returns the title variable.
  # Description:
  # @return [String] title
  def self.title
    # @note Put the yad input as variable titlein
    titlein = `yad --title="Create documentation" --center --on-top --form --item-separator=, --separator=" "  --field="Environment:CBE" --field="Type:CBE" --field="Optional:CBE" --field="Enter a title name (with underscores instead of blanks and without umlauts):TEXT" --field="Please file bugs or feature requests on http://saigkill.ddns.net:8112/dashboard:LBL" --button="Go!" "Work,Private" "Article,Book" "Normal,Report,Homework"`
    # @note Format: Work/Private Article/Book title!Normal Report Homework
    # @note Cleanup the array
    titlechomp = titlein.chomp
    # @note Split the variable to the array title[*]
    title = titlechomp.split(' ')
    return title
  end

  # This method ask for revision information
  # Description:
  # @return [String] revision
  def self.revision
    # @note Put the yad input as variable revhistin
    revhistin = `yad --title="Create Revision" --center --on-top --form --item-separator=, --separator="|" --field="Choose the directory where your project publican.cfg is:LBL" --field="Projectdir:DIR" --field="Enter your first revision text:TEXT" --field="Enter your second revision text:TEXT" --field="Enter your third revision text:TEXT" --field="Enter your fourth revision text:TEXT" --field="Enter your fifth revision text:TEXT" --field="Enter Revision number:TEXT" --button="Go!"`
    # @note Format: Directory|One|Two|Three|Four|Five|Revision
    # @note Cleanup the array
    revhistchomp = revhistin.chomp
    # @note Split the variable to array revision[*]
    revision = revhistchomp.split('|')
    puts revision
    return revision
  end


  # The method gets configuration from a config file.
  # @return [String] name
  # @return [String] email_private
  # @return [String] language
  # @return [String] use_brand
  # @return [String] title_logo
  # @return [String] legal
  # @return [String] brand
  # @return [String] company_name
  # @return [String] company_divison
  # @return [String] email_business
  # @return [String] brand_dir
  # @return [String] globalentities
  # @return [String] articles_dir
  # @return [String] reports_dir
  # @return [String] books_dir
  # @return [String] articles_dir_priv
  # @return [String] homework_priv
  # @return [String] books_dir_priv
  # @return [String] brand_private
  # @return [String] brand_homework
  # @return [String] db5
  # @return [String] conf_ver
  # @return [String] xfc_brand_dir
  # @return [String] pdfview
  def self.config
    home = Dir.home
    config = ParseConfig.new("#{home}/.publicancreators.cfg")
    conf_ver = config['conf_ver']
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
    xfc_brand_dir = config['xfc_brand_dir']
    pdfview = config['pdfview']
    [name, email_private, language, use_brand, title_logo, legal, brand, company_name, company_division, email_business, brand_dir, globalentities, articles_dir, reports_dir, books_dir, articles_dir_priv, homework_dir, books_dir_priv, brand_private, brand_homework, db5, conf_ver, xfc_brand_dir, pdfview]
  end
end