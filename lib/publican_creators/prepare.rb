# PublicanCreatorsPrepare
# @author Sascha Manns
# @abstract Class for preparing the configuration
#
# Copyright (C) 2015-2016  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies

# The module Prepare contains some methods for preparing the directories. They
# will be used in the make directory function
module PublicanCreatorsPrepare
  # This method sets the needed targetdir depending on the environment
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
    if environment == 'Work'
      if type == 'Article'
        targetdir_work(report, reports_dir_business, articles_dir_bus)
      else
        books_dir = "#{home}/#{books_dir_business}"
        return books_dir
      end
    else
      if type == 'Article'
        targetdir_private(homework, articles_dir_private,
                          homework_dir_private)
      else
        books_dir = "#{home}/#{books_dir_private}"
        return books_dir
      end
    end
  end

  # Prepares the articles_dir for work environment
  # @param [String] reports_dir_business contains the directory to your reports
  # @param [String] articles_dir_bus represents the directory for your articles
  # @param [String] report contains a true or false. There you can set if the
  #                 new Publication is a Report or not.
  def self.targetdir_work(report, reports_dir_business, articles_dir_bus)
    home = Dir.home
    if report == 'TRUE'
      articles_dir = "#{home}/#{reports_dir_business}"
    else
      articles_dir = "#{home}/#{articles_dir_bus}"
    end
    return articles_dir
  end

  # Prepares the articles_dir for home environment
  # @param [String] homework contains true or false. If your present Publication
  #                 is a homework you can set it there.
  # @param [String] articles_dir_private contains the path to your private
  #                 articles_dir
  # @param [String] homework_dir_private contains the path to your homework dir.
  def self.targetdir_private(homework, articles_dir_private,
      homework_dir_private)
    home = Dir.home
    if homework == 'FALSE'
      articles_dir = "#{home}/#{articles_dir_private}"
    else
      articles_dir = "#{home}/#{homework_dir_private}"
    end
    return articles_dir
  end
end
