# @author Sascha Manns
# @abstract Class RevisionCreator for PublicanCreator
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
#
# Fix for PC-1
# Dependencies
require 'fileutils'
require 'rainbow/ext/string'
require File.expand_path(File.join(File.dirname(__FILE__), 'change.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'get.rb'))

# A class for creating a revison to a publican project
class RevisionCreator
  # @note Ask for the revision information
  directory, member1, member2, member3, member4, member5, revnumber = PublicanCreatorsGet.revision
  language = PublicanCreatorsGet.config_revision

  revision, edition = revnumber.split('-')

  puts "Directory: #{directory}".color(:yellow)
  puts "Member1: #{member1}".color(:yellow)
  puts "Member2: #{member2}".color(:yellow)
  puts "Member3: #{member3}".color(:yellow)
  puts "Member4: #{member4}".color(:yellow)
  puts "Member5: #{member5}".color(:yellow)
  puts "Language: #{language}".color(:yellow)
  puts "Revnumber: #{revnumber}".color(:yellow)
  puts "Revision: #{revision}".color(:yellow)
  puts "Edition: #{edition}".color(:yellow)

  def self.prepare_revision(member1, member2, member3, member4, member5, revnumber, language)
    string = "--member \"#{member1}\""
    if member2 == ''
      puts 'Do nothing'
    else
      string << " --member \"#{member2}\""
    end
    if member3 == ''
      puts 'Do nothing'
    else
      string << " --member \"#{member3}\""
    end
    if member4 == ''
      puts 'Do nothing'
    else
      string << " --member \"#{member4}\""
    end
    if member5 == ''
      puts 'Do nothing'
    else
      string << " --member \"#{member5}\""
    end
    string << " --revnumber \"#{revnumber}\""
    string << " --lang \"#{language}\""
  end
  # @param [String] directory The directory where the projects publican.cfg is
  FileUtils.cd(directory) do
    string = prepare_revision(member1, member2, member3, member4, member5, revnumber, language)
    PublicanCreatorsChange.replace_productnumber(revision, edition, language)
    system("publican add_revision #{string}")
  end
end