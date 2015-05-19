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
require File.expand_path(File.join(File.dirname(__FILE__), 'get.rb'))

# A class for creating a revison to a publican project
class RevisionCreator
  # @note Ask for the revision information
  revisionget = PublicanCreatorsGet.revision
  directory = revisionget[1]
  member1 = revisionget[2]
  member2 = revisionget[3]
  member3 = revisionget[4]
  member4 = revisionget[5]
  member5 = revisionget[6]
  revnumber = revisionget[7]

  puts "Directory: #{directory}".color(:yellow)
  puts "Member1: #{member1}".color(:yellow)
  puts "Member2: #{member2}".color(:yellow)
  puts "Member3: #{member3}".color(:yellow)
  puts "Member4: #{member4}".color(:yellow)
  puts "Member5: #{member5}".color(:yellow)
  puts "Revnumber: #{revnumber}".color(:yellow)

  # @param [String] directory The directory where the projects publican.cfg is
  FileUtils.cd(directory) do
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
    system("publican add_revision #{string}")
  end
end