# Create Module for PublicanCreators
# PublicanCreatorsChange
# @author Sascha Manns
# @abstract Class for all file changes
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
require 'nokogiri'
require 'dir'
require 'PublicanCreators/checker'

# Class for creating stuff
class PublicanCreatorsCreate
  # Method for creating initial documentation for work. It asks for title, type,
  # language, brand and db5 variable, creates a launch-string from them and
  # launches publican.
  # @param [String] title comes from the get method. This @param represents the
  #                 name or title of your work. It is used in all important code
  #                 places.
  # @param [String] type represents the Document-Type like Article or Book.
  # @param [String] language is just the ISO Code of your target language like:
  #                 de-DE, en-GB or such things.
  # @param [String] brand can be a special customized brand for your company to
  #                 fit the styleguide.
  # @param [String] db5 just sets your preferences. If you like to have DocBook
  #                 5.x as default you can set it there.
  # @return [String] true or false
  # @note That method returns just a success or a fail. After the main part of
  # the method it starts another method "PublicanCreatorsChange.check_result".
  # This method checks if the directory with the content of the parameter title
  # is available.
  def self.init_docu_work(title, type, language, brand, db5)
    puts 'Creating initial documentation ...'
    # Set standard string
    string = "--lang #{language} --name #{title}"
    # Add Article if type is Article
    if type == 'Article'
      string << ' --type Article'
    end
    # Set business brand if given
    string << " --brand #{brand}" if brand != ''
    # @note Check if DocBook 5 wished as default, if yes it adds the parameter
    # dtdver 5.0 to string
    string << ' --dtdver 5.0' if db5 == 'true'
    create_docu(string, title)
  end

  # Method for creating initial documentation for private. It asks for title,
  # type, language, homework, brand_homework, brand_private
  # and db5 variable, creates a launch-string from them and launches publican.
  # @param [String] title comes from the get method. This parameter represents
  #                       the name or title of your work. It is used in all
  #                       important code places.
  # @param [String] type  represents the Document-Type like Article or Book.
  # @param [String] brand_private is used in all methods with a "private" in the
  #                       name. If this brand is set it will be used instead of
  #                       the original publican brand.
  # @param [String] language is just the ISO Code of your target language like:
  #                       de-DE, en-GB or such things.
  # @param [String] brand_homework can be a special customized brand for
  #                       distance learning schools.
  # @param [String] db5 just sets your preferences. If you like to have DocBook
  #                       5.x as default you can set it there.
  # @return [String] true or false
  # @note That method returns just a success or a fail. After the main part of
  # the method it starts another method "PublicanCreatorsChange.check_result".
  # This method checks if the directory with the content of the parameter title
  # is available.
  def self.init_docu_private(title, type, homework, language, brand_homework,
      brand_private, db5)
    puts 'Creating initial documentation ...'

    if type == 'Article'
      string = private_article(language, title, brand_private, brand_homework,
                      homework)
    else
      # @note Initial creation of documentation with publican
      string = "--lang #{language} --name #{title}"
      string << " --brand #{brand_private}" if brand_private != ''
    end
    # @note Check if DocBook 5 wished as default, if yes it adds the parameter
    # dtdver 5.0 to string
    string << ' --dtdver 5.0' if db5 == 'true'
    create_docu(string, title)
  end

  # Method for preparing the string for private articles
  # @param [String] language is just the ISO Code of your target language like:
  #                       de-DE, en-GB or such things.
  # @param [String] title comes from the get method. This parameter represents
  #                       the name or title of your work. It is used in all
  #                       important code places.
  # @param [String] brand_private is used in all methods with a "private" in the
  #                       name. If this brand is set it will be used instead of
  #                       the original publican brand.
  # @param [String] brand_homework can be a special customized brand for
  #                       distance learning schools.
  # @param [String] homework true if homework set
  def self.private_article(language, title, brand_private, brand_homework,
      homework)
    # @note Initial creation of documentation with publican
    string = "--type Article --lang #{language} --name #{title}"
    # Use brand_private if brand_private is set
    if brand_private != '' && homework == 'FALSE'
      string << " --brand #{brand_private}"
    end
    # Use brand_homework if its set
    if brand_homework != '' && homework == 'TRUE'
      string << " --brand #{brand_homework}"
    end
    return string
  end

  # This method uses the input of init_docu methods to create the documentation
  # @param [String] string This input comes from init_docu
  # @param [String] title comes from the get method. This param represents the
  #                     name or title of your work. It is used in all important
  #                     code places.
  # @return [String] true or false
  def self.create_docu(string, title)
    system("publican create #{string}")
    # @param [String] title comes from the get method. This param represents
    # the name or title of your work. It is used in all important code places.
    Checker.check_result(title)
  end
end
