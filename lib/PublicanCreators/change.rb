# Changer Module for PublicanCreators
# It mades all changes in the files
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

require 'nokogiri'
require 'dir'
require 'PublicanCreators/checker'

module PublicanCreatorsChange

  def self.init_docu_work(title, type, language, brand, db5)
    if type == 'Article'
      # Initial creation of documentation with publican
      puts 'Creating initial documentation ...'
      string = "--type Article --lang #{language} --name #{title}"
      if brand == ''
        # do nothing
      else
        string << " --brand #{brand}"
      end
      if db5 == 'true'
        string << ' --dtdver 5.0'
      end
      system("publican create #{string}")
    else
      # Initial creation of documentation with publican
      puts 'Creating initial documentation ...'
      string = "--lang #{language} --name #{title}"
      if brand == ''
        # do nothing
      else
        string << " --brand #{brand}"
      end
      if db5 == 'true'
        string << ' --dtdver 5.0'
      end
      system("publican create #{string}")
    end
    PublicanCreatorsChange.check_result(title)
  end

  def self.init_docu_private(title, type, homework, language, brand_homework, brand_private, db5)
    if type == 'Article'
      # Initial creation of documentation with publican
      if homework == 'FALSE'
        puts 'Creating initial documentation ...'
        string = "--type Article --lang #{language} --name #{title}"
        if brand_private == ''
          # do nothing
        else
          string << " --brand #{brand_private}"
        end
        if db5 == 'true'
          string << ' --dtdver 5.0'
        end
        system("publican create #{string}")
      else
        puts 'Creating initial documentation ...'
        string = "--type Article --lang #{language} --name #{title}"
        if brand_private == ''
          # do nothing
        else
          string << " --brand #{brand_homework}"
        end
        if db5 == 'true'
          string << ' --dtdver 5.0'
        end
        system("publican create #{string}")
      end
    else
      # Initial creation of documentation with publican
      puts 'Creating initial documentation ...'
      string = "--lang #{language} --name #{title}"
      if brand == ''
        # do nothing
      else
        string << " --brand #{brand_private}"
      end
      if db5 == 'true'
        string << ' --dtdver 5.0'
      end
      system("publican create #{string}")
    end
    PublicanCreatorsChange.check_result(title)
  end

  def self.check_result(title)
    # checking if new documentation directory exists
    if Dir.exist?(title)
      puts 'Creating documentation was a success...'
    else
      raise('Cant create documentation. Please try it manual with publican...')
    end
  end

  def self.add_entity(environment, global_entities, brand)
    ent = "#{title}/de-DE/#{title}.ent"
    if environment == 'Work'
      if brand == 'XCOM'
        puts 'Adding global entities...'
        # Adding global entities
        open(ent, 'a') { |f|
          f << "\n"
          f << "<!-- COMMON ENTITIES -->\n"
        }
        input = File.open(global_entities)
        data_to_copy = input.read
        output = File.open(ent, 'a')
        output.write(data_to_copy)
        input.close
        output.close
      end
    else
      puts 'Nothing to do'
    end
  end

  def self.change_holder(title, environment, name, company_name)
    ent = "#{title}/de-DE/#{title}.ent"
    # Replace the Holder with the real one
    puts 'Replace holder field with the present user'
    if environment == 'Work'
      text = File.read(ent)
      new_contents = text.gsub("| You need to change the HOLDER entity in the de-DE/#{title}.ent file |", "#{company_name}")
      puts new_contents
      File.open(ent, 'w') { |file| file.puts new_contents }
    else
      text = File.read(ent)
      new_contents = text.gsub("| You need to change the HOLDER entity in the de-DE/#{title}.ent file |", "#{name}")
      puts new_contents
      File.open(ent, 'w') { |file| file.puts new_contents }
    end
  end

  def self.remove_orgname(artinfo, environment, title_logo)
    # Remove titlepage logo because of doing this with the publican branding files
    if environment == 'Work'
      if type == 'Article'
        if title_logo == 'false'
          puts 'Remove title logo from Article_Info'
          doc = Nokogiri::XML(IO.read(artinfo))
          doc.search('orgname').each do |node|
            node.remove
            node.content = 'Children removed'
          end
          IO.write(artinfo, doc.to_xml)
        end
      else
        puts 'Nothing to do'
      end
    end
  end

  def self.remove_legal(environment, type, legal)
    artinfo = "#{title}/de-DE/Article_Info.xml"
    if environment == 'Work'
      if type == 'Article'
        if legal == 'true'
          # Remove the Legal Notice XI-Include in case it is an article. XCOM articles using another way to add them.
          puts 'Remove XI-Includes for Legal Notice...'
          text = File.read(artinfo)
          new_contents = text.gsub('<xi:include href="Common_Content/Legal_Notice.xml" xmlns:xi="http://www.w3.org/2001/XInclude" />', '<!-- removed legal -->')
          puts new_contents
          File.open(artinfo, 'w') { |file| file.puts new_contents }
        end
      else
        puts 'Nothing to do'
      end
    else
      puts 'Nothing to do'
    end

  end

  def self.fix_revhist(environment, name, email_business, email)
    revhist = "#{title}/de-DE/Revision_History.xml"
    namechomp = name.chomp
    # Split the variable to the array title[*]
    name = namechomp.split(' ')
    firstname = name[0]
    surname = name[1]
    # Revision_History: Change default stuff to the present user
    puts 'Replace the default content with the new content from the user (Revision History)'
    text = File.read(revhist)
    vorname = text.gsub('Enter your first name here.', "#{firstname}")
    puts vorname
    File.open(revhist, 'w') { |file|
      file.puts vorname
    }
    text = File.read(revhist)
    nachname = text.gsub('Enter your surname here.', "#{surname}")
    puts nachname
    File.open(revhist, 'w') { |file|
      file.puts nachname
    }
    text = File.read(revhist)
    if environment == 'Work'
      email = text.gsub('Enter your email address here.', "#{email_business}")
    else
      email = text.gsub('Enter your email address here.', "#{email}")
    end
    puts email
    File.open(revhist, 'w') { |file|
      file.puts email
    }
    text = File.read(revhist)
    member = text.gsub('Initial creation by publican', 'Initial creation')
    puts member
    File.open(revhist, 'w') { |file|
      file.puts member
    }
  end

  def self.fix_authorgroup(environment, name, email, email_business, company_name, company_division)
    agroup = "#{title}/de-DE/Author_Group.xml"
    namechomp = name.chomp
    # Split the variable to the array title[*]
    name = namechomp.split(' ')
    firstname = name[0]
    surname = name[1]
    # Author Group: Change the default stuff to the present user
    puts 'Replace the default content with the new content from the user (Authors_Group)'
    text = File.read(agroup)
    vorname = text.gsub('Enter your first name here.', "#{firstname}")
    puts vorname
    File.open(agroup, 'w') { |file|
      file.puts vorname
    }
    text = File.read(agroup)
    nachname = text.gsub('Enter your surname here.', "#{surname}")
    puts nachname
    File.open(agroup, 'w') { |file|
      file.puts nachname
    }
    text = File.read(agroup)
    if environment == 'Work'
      email = text.gsub('Enter your email address here.', "#{email_business}")
    else
      email = text.gsub('Enter your email address here.', "#{email}")
    end
    puts email
    File.open(agroup, 'w') { |file|
      file.puts email
    }
    text = File.read(agroup)
    member = text.gsub('Initial creation by publican', 'Initial creation')
    puts member
    File.open(agroup, 'w') { |file|
      file.puts member
    }
    text = File.read(agroup)
    if environment == 'Work'
      org = text.gsub('Enter your organisation\'s name here.', "#{company_name}")
    else
      org = text.gsub('Enter your organisation\'s name here.', '')
    end
    puts org
    File.open(agroup, 'w') { |file|
      file.puts org
    }
    text = File.read(agroup)
    if environment == 'Work'
      div = text.gsub('Enter your organisational division here.', "#{company_division}")
    else
      div = text.gsub('Enter your organisational division here.', '')
    end
    puts div
    File.open(agroup, 'w') { |file|
      file.puts div
    }
  end

  def self.make_buildscript_exe(builds)
    # Make the buildscript executable
    puts 'Making the buildscript executable ...'
    FileUtils.chmod 'u=rwx,go=rwx', "#{builds}"
  end
end