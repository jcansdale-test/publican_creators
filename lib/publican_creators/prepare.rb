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

# The module Prepare contains some methods for preparing the directories. They
# will be used in the make directory function
module PublicanCreatorsPrepare
  # This method sets the needed targetdir depending on the environment
  # @param [String] environment Work or Private
  # @param [String] type represents the Document-Type like Article or Book.
  # @param [String] reports_dir_business contains the directory to your reports
  # @param [String] articles_dir_bus represents the directory for your articles
  # @param [String] report contains a true or false. There you can set if the
  #                 new Publication is a Report or not.
  # @param [String] books_dir_business contains the directory for your business
  #                 books
  # @param [String] homework contains true or false. If your present Publication
  #                 is a homework you can set it there.
  # @param [String] articles_dir_private contains the path to your private
  #                 articles_dir
  # @param [String] homework_dir_private contains the path to your homework dir.
  # @param [String] books_dir_private contains the path to your private
  #                 books_dir
  # @return [String] targetdir
  def self.targetdir(environment, type, report, reports_dir_business,
                     articles_dir_bus, books_dir_business, homework,
                     articles_dir_private, homework_dir_private, books_dir_private)
    home = Dir.home
    # TODO: Try to fix this in future
    # rubocop:disable Style/IfInsideElse
    if environment == 'Work'
      if type == 'Article'
        targetdir_work(report, reports_dir_business, articles_dir_bus)
      else
        books_dir = "#{home}/#{books_dir_business}"
        return books_dir
      end
    else
      if type == 'Article'
        targetdir_private(homework, articles_dir_private, homework_dir_private)
      else
        books_dir = "#{home}/#{books_dir_private}"
        return books_dir
      end
    end
  end

  # Prepares the articles_dir for work environment
  # @param [String] report contains a true or false. There you can set if the
  #                 new Publication is a Report or not.
  # @param [String] reports_dir_business contains the directory to your reports
  # @param [String] articles_dir_bus represents the directory for your articles
  def self.targetdir_work(report, reports_dir_business, articles_dir_bus)
    home = Dir.home
    articles_dir = if report == 'TRUE'
                     "#{home}/#{reports_dir_business}"
                   else
                     "#{home}/#{articles_dir_bus}"
                   end
    return articles_dir
  end

  # Prepares the articles_dir for home environment
  # @param [String] homework contains true or false. If your present Publication
  #                 is a homework you can set it there.
  # @param [String] articles_dir_private contains the path to your private
  #                 articles_dir
  # @param [String] homework_dir_private contains the path to your homework dir.
  def self.targetdir_private(homework, articles_dir_private, homework_dir_private)
    home = Dir.home
    articles_dir = if homework == 'FALSE'
                     "#{home}/#{articles_dir_private}"
                   else
                     "#{home}/#{homework_dir_private}"
                   end
    return articles_dir
  end
end
