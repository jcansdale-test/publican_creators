# @author Sascha Manns
# @abstract Class RevisionCreator for PublicanCreator
#
# Copyright (C) 2015-2016  Sascha Manns <samannsml@directbox.com>
# License: MIT
#
# Dependencies
require 'fileutils'
require 'rainbow/ext/string'
require File.expand_path(File.join(File.dirname(__FILE__), 'change.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'get.rb'))

# A class for creating a revison to a publican project
class RevisionCreator
  # @note Ask for the revision information
  null, directory, member1, member2, member3, member4, member5,
      revnumber = PublicanCreatorsGet.revision
  language = PublicanCreatorsGet.config_revision

  revision, edition = revnumber.split('-')

  puts "Directory: #{directory}"
  puts "Member1: #{member1}"
  puts "Member2: #{member2}"
  puts "Member3: #{member3}"
  puts "Member4: #{member4}"
  puts "Member5: #{member5}"
  puts "Language: #{language}"
  puts "Revnumber: #{revnumber}"
  puts "Revision: #{revision}"
  puts "Edition: #{edition}"
  puts null

  # This method prepares the string for adding a new revision
  # @param [String] member1 is the first string into revdescription
  # @param [String] member2 is the second string into revdescription
  # @param [String] member3 is the third string into revdescription
  # @param [String] member4 is the fourth string into revdescription
  # @param [String] member5 is the fifth string into revdescription
  # @param [String] revnumber is the revision number
  # @param [String] language is the language. Comes from config file.
  # @return [String] string is that string for creating the commit
  def self.prepare_revision(member1, member2, member3, member4, member5,
      revnumber, language)
    string = "--member \"#{member1}\""
    string << " --member \"#{member2}\"" if member2 != ''
    string << " --member \"#{member3}\"" if member3 != ''
    string << " --member \"#{member4}\"" if member4 != ''
    string << " --member \"#{member5}\"" if member5 != ''
    string << " --revnumber \"#{revnumber}\""
    string << " --lang \"#{language}\""
  end

  # This method changes to the target directory
  FileUtils.cd(directory) do
    string = prepare_revision(member1, member2, member3, member4, member5,
                              revnumber, language)
    PublicanCreatorsChange.replace_productnumber(revision, edition, language)
    system("publican add_revision #{string}")
  end
end
