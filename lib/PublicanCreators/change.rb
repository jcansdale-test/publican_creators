# Changer Module for PublicanCreators
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
require 'rainbow/ext/string'
require 'PublicanCreators/checker'

# @note Module what contains all methods who are doing changes in files
module PublicanCreatorsChange

  # Method for creating initial documentation for work. It asks for title, type, language, brand and db5 variable, creates a launch-string from them and launches publican.
  # Descriptions:
  # @param [String] title comes from the get method. This @param represents the name or title of your work. It is used in all important code places.
  # @param [String] type represents the Document-Type like Article or Book.
  # @param [String] language is just the ISO Code of your target language like: de-DE, en-GB or such things.
  # @param [String] brand can be a special customized brand for your company to fit the styleguide.
  # @param [String] db5 just sets your preferences. If you like to have DocBook 5.x as default you can set it there.
  # @return [String] true or false
  # @note That method returns just a success or a fail. After the main part of the method it starts another method "PublicanCreatorsChange.check_result". This method checks
  #  if the directory with the content of the @param title [String] is available.
  def self.init_docu_work(title, type, language, brand, db5)
    if type == 'Article'
      # @note Initial creation of documentation with publican
      puts 'Creating initial documentation ...'.color(:yellow)
      string = "--type Article --lang #{language} --name #{title}"
      if brand == ''
        # @note do nothing
      else
        string << " --brand #{brand}"
      end
    else
      # @note Initial creation of documentation with publican
      puts 'Creating initial documentation ...'.color(:yellow)
      string = "--lang #{language} --name #{title}"
      if brand == ''
        # do nothing
      else
        string << " --brand #{brand}"
      end
    end
    # @note Check if DocBook 5 wished as default, if yes it adds the @param dtdver 5.0 to string
    if db5 == 'true'
      string << ' --dtdver 5.0'
    end
    system("publican create #{string}")
    # @param [String] title comes from the get method. This @param represents the name or title of your work. It is used in all important code places.
    PublicanCreatorsChange.check_result(title)
  end

  # Method for creating initial documentation for private. It asks for title, type, language, homework, brand_homework, brand_private
  # and db5 variable, creates a launch-string from them and launches publican.
  # Descriptions:
  # @param [String] title comes from the get method. This @param represents the name or title of your work. It is used in all important code places.
  # @param [String] type represents the Document-Type like Article or Book.
  # @param [String] brand_private is used in all methods with a "private" in the name. If this brand is set it will be used instead of the original publican brand.
  # @param [String] language is just the ISO Code of your target language like: de-DE, en-GB or such things.
  # @param [String] brand_homework can be a special customized brand for distance learning schools.
  # @param [String] db5 just sets your preferences. If you like to have DocBook 5.x as default you can set it there.
  # @return [String] true or false
  # @note That method returns just a success or a fail. After the main part of the method it starts another method "PublicanCreatorsChange.check_result". This method checks
  #  if the directory with the content of the @param title [String] is available.
  def self.init_docu_private(title, type, homework, language, brand_homework, brand_private, db5)
    if type == 'Article'
      # @note Initial creation of documentation with publican
      if homework == 'FALSE'
        puts 'Creating initial documentation ...'.color(:yellow)
        string = "--type Article --lang #{language} --name #{title}"
        if brand_private == ''
          # @note do nothing
        else
          string << " --brand #{brand_private}"
        end
      else
        puts 'Creating initial documentation ...'.color(:yellow)
        string = "--type Article --lang #{language} --name #{title}"
        if brand_private == ''
          # do nothing
        else
          string << " --brand #{brand_homework}"
        end
      end
    else
      # @note Initial creation of documentation with publican
      puts 'Creating initial documentation ...'.color(:yellow)
      string = "--lang #{language} --name #{title}"
      if brand_private == ''
        # @note do nothing
      else
        string << " --brand #{brand_private}"
      end
    end
    if db5 == 'true'
      string << ' --dtdver 5.0'
    end
    system("publican create #{string}").color(:yellow)
    # @param [String] title comes from the get method. This @param represents the name or title of your work. It is used in all important code places.
    PublicanCreatorsChange.check_result(title)
  end

  # This method will be launched from the init_docu_* methods. It returns a success, otherwise it raises with a error.
  # Descriptions:
  # @param [String] title comes from the get method. This @param represents the name or title of your work. It is used in all important code places.
  # @return [String] true or false
  def self.check_result(title)
    # @note checking if new documentation directory exists
    if Dir.exist?(title)
      puts 'Creating documentation was a success...'.color(:yellow)
    else
      raise('Cant create documentation. Please try it manual with publican...').color(:red)
    end
  end

  # By working for my employer i'm creating publications which refers to a global entity file.
  # This method adds the entities from that file into the local one. It returns a success or fail.
  # Descriptions:
  # @param [String] title comes from the get method. This @param represents the name or title of your work. It is used in all important code places.
  # @param [String] environment shows if you actually want to create a private or Business Publication. If Work is given it reads your global entity file and appends it on the ent file.
  # @param [String] global_entities is just the path to the global entity file.
  # @param [String] brand can be a special customized brand for your company to fit the Styleguide.
  # @return [String] true or false
  def self.add_entity(title, environment, global_entities, brand)
    ent = "#{title}/de-DE/#{title}.ent"
    if environment == 'Work'
      if brand == 'XCOM'
        puts 'Adding global entities...'.color(:yellow)
        # @note Adding global entities
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
      puts 'Nothing to do'.color(:yellow)
    end
  end

  # In this method the standard-holder from the local entity-file will be replaced with the company_name or if it is a private work the name of the present user. It returns a sucess or fail.
  # Descriptions:
  # @param [String] title comes from the get method. This @param represents the name or title of your work. It is used in all important code places.
  # @param [String] environment shows if you actually want to create a private or Business Publication. If Work is given it reads your global entity file and appends it on the ent file.
  # @param [String] name is your name.
  # @param [String] company_name is the name of your company
  # @return [String] true or false
  # @note If the environment "Work" is given the entity file will be set as HOLDER otherwise it sets your name.
  def self.change_holder(title, environment, name, company_name)
    ent = "#{title}/de-DE/#{title}.ent"
    # @note Replace the Holder with the real one
    puts 'Replace holder field with the present user'.color(:yellow)
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

  # This method removes the <orgname> node from the XML file. Remove titlepage logo because of doing this with the publican branding files. This method will applied if
  # environment [String] is Work, "type" is Article and title_logo is "false".
  # It returns a sucess or fail.
  # Descriptions:
  # @param [String] artinfo can be other than the @param name says a path to the Article_Info or Book_Info. Which is used there depends on the @param "type".
  # @param [String] title_logo means that you can set if you want to use Publican's Title Logo or use your own Title Logo with your Stylesheets.
  # @return [String] true or false
  def self.remove_orgname(info, title_logo)
    if title_logo == 'false'
      puts 'Remove title logo from Article_Info or Books_Info'.color(:yellow)
      doc = Nokogiri::XML(IO.read(info))
      doc.search('orgname').each do |node|
        node.remove
        node.content = 'Children removed'
      end
      IO.write(info, doc.to_xml)
    end
  end

  # This method removes the XI-Includes for the legal notice
  # It returns a sucess or fail.
  # Descriptions:
  # @param [String] title comes from the get method. This @param represents the name or title of your work. It is used in all important code places.
  # @param [String] environment shows if you actually want to create a private or Business Publication. If Work is given it reads your global entity file and appends it on the ent file.
  # @param [String] type represents the Document-Type like Article or Book.
  # @param [String] legal means if you don't like to have a Legal Notice on Publican's default place you can define it there. Actually it just works with Articles. In my case i'm
  # using the Legal Notice inside the Article's Structure.
  # @return [String] true or false
  def self.remove_legal(title, environment, type, legal)
    artinfo = "#{title}/de-DE/Article_Info.xml"
    if environment == 'Work'
      if type == 'Article'
        if legal == 'true'
          # @note Remove the Legal Notice XI-Include in case it is an article. XCOM articles using another way to add them.
          puts 'Remove XI-Includes for Legal Notice...'.color(:yellow)
          text = File.read(artinfo)
          new_contents = text.gsub('<xi:include href="Common_Content/Legal_Notice.xml" xmlns:xi="http://www.w3.org/2001/XInclude" />', '<!-- removed legal -->')
          puts new_contents
          File.open(artinfo, 'w') { |file| file.puts new_contents }
        end
      else
        puts 'Nothing to do'.color(:yellow)
      end
    else
      puts 'Nothing to do'.color(:yellow)
    end

  end

  # This method splits the name variable into firstname and surname. These variables are setted into the Revision_History. If the environment is "Work" your email_business
  # will be used, otherwise your private email_address.
  # It returns a sucess or fail.
  # Descriptions:
  # @param [String] title comes from the get method. This @param represents the name or title of your work. It is used in all important code places.
  # @param [String] environment shows if you actually want to create a private or Business Publication. If Work is given it reads your global entity file and appends it on the ent file.
  # @param [String] name is your name.
  # @param [String] email_business is your business email address.
  # @param [String] email is your private email address.
  # @return [String] true or false
  def self.fix_revhist(environment, name, email_business, email, title)
    revhist = "#{title}/de-DE/Revision_History.xml"
    namechomp = name.chomp
    # @note Split the variable to the array title[*]
    name = namechomp.split(' ')
    firstname = name[0]
    surname = name[1]
    # @note Revision_History: Change default stuff to the present user
    puts 'Replace the default content with the new content from the user (Revision History)'.color(:yellow)
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

  # This method replaces the standard values from Author_Group to the present user issues. It will be launched for the Work environment. It returns a sucess or fail.
  # Descriptions:
  # @param [String] title comes from the get method. This variable contains the name or title of your work. It is used in all important code places.
  # @param [String] name is your name.
  # @param [String] email_business is your business email address.
  # @param [String] company_name is just your companies name.
  # @param [String] company_division is your companies part/division.
  # @return [String] true or false
  def self.fix_authorgroup_work(title, name, email_business, company_name, company_division)
    agroup = "#{title}/de-DE/Author_Group.xml"
    namechomp = name.chomp
    # @note Split the variable to the array title[*]
    name = namechomp.split(' ')
    firstname = name[0]
    surname = name[1]
    # @note Author Group: Change the default stuff to the present user
    puts 'Replace the default content with the new content from the user (Authors_Group)'.color(:yellow)
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
    email = text.gsub('Enter your email address here.', "#{email_business}")
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

    org = text.gsub('Enter your organisation\'s name here.', "#{company_name}")
    puts org
    File.open(agroup, 'w') { |file|
      file.puts org
    }
    text = File.read(agroup)
    div = text.gsub('Enter your organisational division here.', "#{company_division}")
    puts div
    File.open(agroup, 'w') { |file|
      file.puts div
    }
  end

  # This method replaces the standard values from Author_Group to the present user issues. It will be launched for the Private environment. It returns a success or fail.
  # Descriptions:
  # @param [String] title comes from the get method. This @param represents the name or title of your work. It is used in all important code places.
  # @param [String] name is your name.
  # @param [String] email is your private email address.
  # @return [String] true or false
  def self.fix_authorgroup_private(name, email, title)
    agroup = "#{title}/de-DE/Author_Group.xml"
    namechomp = name.chomp
    # @note Split the variable to the array title[*]
    name = namechomp.split(' ')
    firstname = name[0]
    surname = name[1]
    # @note Author Group: Change the default stuff to the present user
    puts 'Replace the default content with the new content from the user (Authors_Group)'.color(:yellow)
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
    email = text.gsub('Enter your email address here.', "#{email}")

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
    org = text.gsub('Enter your organisation\'s name here.', '')

    puts org
    File.open(agroup, 'w') { |file|
      file.puts org
    }
    text = File.read(agroup)
    div = text.gsub('Enter your organisational division here.', '')

    puts div
    File.open(agroup, 'w') { |file|
      file.puts div
    }
  end

  # Make the buildscript executable
  # It returns a sucess or fail.
  # Description:
  # @param [String] builds is the path to your buildscript
  # @return [String] true or false
  def self.make_buildscript_exe(builds)
    puts 'Making the buildscript executable ...'.color(:yellow)
    FileUtils.chmod 'u=rwx,go=rwx', "#{builds}"
  end
end