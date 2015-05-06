# Prepare Module for PublicanCreators
# It prepares the configuration
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

# The module Prepare contains some methods for preparing the directories. They will be used in the make directory function
module PublicanCreatorsPrepare

  # In case of environment == Work this tests will be launched.
  def self.prepare_work(type, reports_dir_business, articles_dir_bus, report, books_dir_business)
    if type == 'Article'
      articles_dir = PublicanCreatorsPrepare.prepare_target_work_article(reports_dir_business, articles_dir_bus, report)
      return articles_dir
    else
      books_dir = PublicanCreatorsPrepare.prepare_target_work_book(books_dir_business)
      return books_dir
    end
  end

  # In case of environment == Private this tests will be launched.
  def self.prepare_private(type, homework, articles_dir_private, homework_dir_private, books_dir_private)
    if type == 'Article'
      articles_dir = PublicanCreatorsPrepare.prepare_target_private_article(homework, articles_dir_private, homework_dir_private)
      return articles_dir
    else
      books_dir = PublicanCreatorsPrepare.prepare_target_private_book(books_dir_private)
      return books_dir
    end
  end

  # In case of type == Article this tests will be launched
  def self.prepare_target_work_article(reports_dir_business, articles_dir_bus, report)
    home = Dir.home
    if report == 'TRUE'
      articles_dir = "#{home}/#{reports_dir_business}"
    else
      articles_dir = "#{home}/#{articles_dir_bus}"
    end
    return articles_dir
  end

  # In case of type == Book this tests will be launched
  def self.prepare_target_work_book(books_dir_business)
    home = Dir.home
    books_dir = "#{home}/#{books_dir_business}"
    return books_dir
  end

  # This method prepares the target directory for a private article
  def self.prepare_target_private_article(homework, articles_dir_private, homework_dir_private)
    home = Dir.home
    if homework == 'FALSE'
      articles_dir = "#{home}/#{articles_dir_private}"
    else
      articles_dir = "#{home}/#{homework_dir_private}"
    end
    return articles_dir
  end

  # This method prepares the target directory for a private book
  def self.prepare_target_private_book(books_dir_private)
    home = Dir.home
    books_dir = "#{home}/#{books_dir_private}"
    return books_dir
  end

end