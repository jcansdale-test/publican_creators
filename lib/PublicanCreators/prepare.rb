# PublicanCreatorsPrepare
# @author Sascha Manns
# @abstract Class for preparing the configuration
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

# The module Prepare contains some methods for preparing the directories. They will be used in the make directory function
module PublicanCreatorsPrepare

  def self.targetdir(environment, type, report, reports_dir_business, articles_dir_bus, books_dir_business, homework,
      articles_dir_private, homework_dir_private, books_dir_private)
    home = Dir.home
    if environment == 'Work'
      if type == 'Article'
        if report == 'TRUE'
          articles_dir = "#{home}/#{reports_dir_business}"
        else
          articles_dir = "#{home}/#{articles_dir_bus}"
        end
        return articles_dir
      else
        books_dir = "#{home}/#{books_dir_business}"
        return books_dir
      end
    else
      if type == 'Article'
        if homework == 'FALSE'
          articles_dir = "#{home}/#{articles_dir_private}"
        else
          articles_dir = "#{home}/#{homework_dir_private}"
        end
        return articles_dir
      else
        books_dir = "#{home}/#{books_dir_private}"
        return books_dir
      end
    end
  end
  # In case of environment == Work this tests will be launched. It returns a article or books dir
  # @param [String] type represents the Document-Type like Article or Book.
  # @param [String] reports_dir_business contains the directory to your reports
  # @param [String] articles_dir_bus represents the directory for your articles
  # @param [String] report contains a true or false. There you can set if the new Publication is a Report or not.
  # @param [String] books_dir_business contains the directory for your business books
  # @return [String] books_dir returns article_dir or books_dir
  # def self.prepare_work(type, reports_dir_business, articles_dir_bus, report, books_dir_business)
  #   home = Dir.home
  #   if type == 'Article'
  #     if report == 'TRUE'
  #       articles_dir = "#{home}/#{reports_dir_business}"
  #     else
  #       articles_dir = "#{home}/#{articles_dir_bus}"
  #     end
  #     return articles_dir
  #   else
  #     books_dir = "#{home}/#{books_dir_business}"
  #     return books_dir
  #   end
  # end

  # In case of environment == Private this tests will be launched.
  # PublicanCreatorsPrepare.prepare_private returns the content of the variables articles_dir or books_dir
  # Description:
  # @param [String] type represents the Document-Type like Article or Book.
  # @param [String] homework contains true or false. If your present Publication is a homework you can set it there.
  # @param [String] articles_dir_private contains the path to your private articles_dir
  # @param [String] homework_dir_private contains the path to your homework dir.
  # @param [String] books_dir_private contains the path to your private books_dir
  # @return [String] books_dir or articles_dir
  # def self.prepare_private(type, homework, articles_dir_private, homework_dir_private, books_dir_private)
  #   home = Dir.home
  #   if type == 'Article'
  #     if homework == 'FALSE'
  #       articles_dir = "#{home}/#{articles_dir_private}"
  #     else
  #       articles_dir = "#{home}/#{homework_dir_private}"
  #     end
  #     return articles_dir
  #   else
  #     books_dir = "#{home}/#{books_dir_private}"
  #     return books_dir
  #   end
  # end

  # This method prepares the targetdir
  # @param [String] type represents the Document-Type like Article or Book.
  # @param [String] reports_dir_business contains the directory to your reports
  # @param [String] articles_dir_bus represents the directory for your articles
  # @param [String] report contains a true or false. There you can set if the new Publication is a Report or not.
  # @param [String] books_dir_business contains the directory for your business books
  # @return [String] books_dir returns article_dir or books_dir
  # @param [String] homework contains true or false. If your present Publication is a homework you can set it there.
  # @param [String] articles_dir_private contains the path to your private articles_dir
  # @param [String] homework_dir_private contains the path to your homework dir.
  # @param [String] books_dir_private contains the path to your private books_dir
  # @return [String] targetdir
  # def self.prepare(environment, type, reports_dir_business, articles_dir_bus, report, books_dir_business,homework, articles_dir_private, homework_dir_private, books_dir_private)
  #   if environment == 'Work'
  #     targetdir = prepare_work(type, reports_dir_business, articles_dir_bus, report, books_dir_business)
  #   else
  #     targetdir = prepare_private(type, homework, articles_dir_private, homework_dir_private, books_dir_private)
  #   end
  #   return targetdir
  # end
end