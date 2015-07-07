# Changer Module for PublicanCreators
# PublicanCreatorsChange
# @author Sascha Manns
# @abstract Class for all file changes
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: GPL-3

# Dependencies

require 'nokogiri'
require 'PublicanCreators/create'
require 'PublicanCreators/checker'
require 'MannsShared'

# Module what contains all methods who are doing changes in files
module PublicanCreatorsChange
  # Method for replacing content in agroup
  # @param [String] nice_description is the default text in the target file
  # @param [String] value_name the replace text
  # @param [String] file Target file like Author_Group.xml
  # @return [String] true or false
  def self.add_result(nice_description, value_name, file)
    text = File.read(file)
    new_value = text.gsub(nice_description, value_name)
    puts new_value
    File.open(file, 'w') do |file1|
      file1.puts new_value
    end
  end

  # This method checks the environment and runs the method for
  # @param [String] environment shows if you actually want to create a private
  #                             or Business Publication. If Work is given it
  #                             reads your global entity file and appends it on
  #                             the ent file.
  # @param [String] title comes from the get method. This param represents the
  #                 name or title of your work. It is used in all important
  #                 code places.
  # @param [String] type represents the Document-Type like Article or Book.
  # @param [String] language is just the ISO Code of your target language like:
  #                 de-DE, en-GB or such things.
  # @param [String] brand can be a special customized brand for your company to
  #                 fit the styleguide.
  # @param [String] db5 just sets your preferences. If you like to have DocBook
  #                 5.x as default you can set it there.
  # @param [String] brand_homework can be a special customized brand for
  #                 distance learning schools.
  # @param [String] brand_private is used in all methods with a "private" in the
  #                 name. If this brand is set it will be used instead of the
  #                 original publican brand.
  # @param [String] homework if homework is set
  # @return [String] true or false
  def self.check_environment(environment, title, type, language, brand, db5,
      homework, brand_homework, brand_private)
    if environment == 'Work'
      PublicanCreatorsCreate.init_docu_work(title, type, language, brand, db5)
    else
      PublicanCreatorsCreate.init_docu_private(title, type, homework, language,
                                               brand_homework, brand_private,
                                               db5)
    end
  end

  # By working for my employer i'm creating publications which refers to a
  # global entity file.
  # This method adds the entities from that file into the local one. It returns
  # a success or fail.
  # @param [String] environment shows if you actually want to create a private
  #                 or Business Publication. If Work is given it reads your
  #                 global entity file and appends it on the ent file.
  # @param [String] global_entities is just the path to the global entity file.
  # @param [String] ent Path to the entity file
  # @return [String] true or false
  # This method smells of :reek:UncommunicativeVariableName
  def self.add_entity(environment, global_entities, ent)
    if environment == 'Work'
      if global_entities.empty?
        puts 'Nothing to do'
      else
        puts 'Adding global entities...'
        # @note Adding global entities
        open(ent, 'a') do |f|
          f << "\n"
          f << "<!-- COMMON ENTITIES -->\n"
        end
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

  # In this method the standard-holder from the local entity-file will be
  # replaced with the company_name or if it is a private work the name of the
  # present user. It returns a sucess or fail.
  # @param [String] title comes from the get method. This @param represents the
  #                 name or title of your work. It is used in all important code
  #                 places.
  # @param [String] environment shows if you actually want to create a private
  #                 or Business Publication. If Work is given it reads your
  #                 global entity file and appends it on the ent file.
  # @param [String] name is your name.
  # @param [String] company_name is the name of your company
  # @param [String] ent Path to the entity file
  # @return [String] true or false
  # @note If the environment "Work" is given the entity file will be set as
  # HOLDER otherwise it sets your name.
  def self.change_holder(title, environment, name, company_name, ent)
    # @note Replace the Holder with the real one
    puts 'Replace holder field with the present user'
    if environment == 'Work'
      namefill = "#{company_name}"
    else
      namefill = "#{name}"
    end
    change_holder_do(namefill, title, ent)
  end

  # This method does the changes
  # @param [String] namefill can be the name or the company_name depends on
  #                 environment
  # @param [String] title comes from the get method. This @param represents the
  #                 name or title of your work. It is used in all important code
  #                 places.
  # @param [String] ent Path to the entity file
  # @return [String] true or false
  def self.change_holder_do(namefill, title, ent)
    text = File.read(ent)
    new_contents = text.gsub("| You need to change the HOLDER entity in the \
de-DE/#{title}.ent file |", "#{namefill}")
    puts new_contents
    File.open(ent, 'w') { |file| file.puts new_contents }
  end

  # This method removes the <orgname> node from the XML file. Remove titlepage
  # logo because of doing this with the publican branding files. This method
  # will applied if environment is Work, "type" is Article and title_logo is
  # "false".
  # It returns a sucess or fail.
  # @param [String] info can be bookinfo or artinfo
  # @param [String] title_logo means that you can set if you want to use
  #                 Publican's Title Logo or use your own Title Logo with your
  #                 Stylesheets.
  # @return [String] true or false
  def self.remove_orgname(info, title_logo)
    if title_logo == 'false'
      puts 'Remove title logo from Article_Info or Books_Info'
      puts info
      doc = Nokogiri::XML(IO.read(info))
      doc.search('orgname').each do |node|
        node.remove
        node.content = 'Children removed'
      end
      IO.write(info, doc.to_xml)
    end
  end

  # Checks if bookinfo or artinfo is needed, then it starts remove_orgname
  # @param [String] bookinfo Book_Info. Which is used there depends on the
  #                 param "type".
  # @param [String] artinfo Article_Info. Which is used there depends on the
  #                 param "type".
  # @param [String] title_logo means that you can set if you want to use
  #                 Publican's Title Logo or use your own Title Logo with your
  #                 Stylesheets.
  # @param [String] type represents the Document-Type like Article or Book.
  def self.remove_orgname_prepare(bookinfo, artinfo, title_logo, type)
    info = artinfo if type == 'Article'
    info = bookinfo if type == 'Book'
    remove_orgname(info, title_logo)
  end
  # This method replaces the old productversion to the new revision
  # @param [String] language The default language from the config file
  # @param [String] revision The new revision number
  # @param [String] edition The new edition number
  # @return [String] true or false
  def self.replace_productnumber(revision, edition, language)
    puts 'Replacing the productnumber'
    if File.exist?("#{language}/Article_Info.xml")
      info = "#{language}/Article_Info.xml"
    else
      info = "#{language}/Book_Info.xml"
    end
    doc = Nokogiri::XML(IO.read(info))
    doc.search('productnumber').each do |node|
      node.content = "#{revision}"
    end
    doc.search('edition').each do |node|
      node.content = "#{edition}"
    end
    IO.write(info, doc.to_xml)
  end

  # This method removes the XI-Includes for the legal notice
  # It returns a sucess or fail.
  # @param [String] environment shows if you actually want to create a private
  #                 or Business Publication. If Work is given it reads your
  #                 global entity file and appends it on the ent file.
  # @param [String] type represents the Document-Type like Article or Book.
  # @param [String] legal means if you don't like to have a Legal Notice on
  #                 Publican's default place you can define it there. Actually
  #                 it just works with Articles. In my case i'm using the
  #                 Legal Notice inside the Article's Structure.
  # @param [String] artinfo Article_Info. Which is used there depends on the
  #                 param "type".
  # @return [String] true or false
  def self.remove_legal(environment, type, legal, artinfo)
    if environment == 'Work'
      if type == 'Article'
        if legal == 'true'
          # @note Remove the Legal Notice XI-Include in case it is an article.
          # XCOM articles using another way to add them.
          puts 'Remove XI-Includes for Legal Notice...'
          text = File.read(artinfo)
          # rubocop:disable Metrics/LineLength
          new_contents = text.gsub('<xi:include href="Common_Content/Legal_Notice.xml" xmlns:xi="http://www.w3.org/2001/XInclude" />', '')
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

  # This method splits the name variable into firstname and surname. These
  # variables are setted into the Revision_History. If the environment is "Work"
  # your email_business will be used, otherwise your private email_address.
  # It returns a sucess or fail.
  # @param [String] revhist Path to the Revision_History
  # @param [String] environment shows if you actually want to create a private
  #                 or Business Publication. If Work is given it reads your
  #                 global entity file and appends it on the ent file.
  # @param [String] name is your name.
  # @param [String] email_business is your business email address.
  # @param [String] email is your private email address.
  # @return [String] true or false
  def self.fix_revhist(environment, name, email_business, email, revhist)
    firstname, surname = get_name(name)
    # @note Revision_History: Change default stuff to the present user
    puts 'Replace the default content with the new content from the user
(Revision History)'
    add_result('Enter your first name here.', "#{firstname}", revhist)
    add_result('Enter your surname here.', "#{surname}", revhist)
    add_result('Initial creation by publican', 'Initial creation', revhist)

    if environment == 'Work'
      add_result('Enter your email address here.', "#{email_business}", revhist)
    else
      add_result('Enter your email address here.', "#{email}", revhist)
    end
  end

  # This method replaces the standard values from Author_Group to the present
  # user issues. It will be launched for the Work environment. It returns a
  # sucess or fail.
  # @param [String] name is your name.
  # @param [String] email_business is your business email address.
  # @param [String] company_name is just your companies name.
  # @param [String] company_division is your companies part/division.
  # @param [String] email is your private email address.
  # @param [String] environment shows if you actually want to create a private
  #                 or Business Publication. If Work is given it reads your
  #                 global entity file and appends it on the ent file.
  # @param [String] agroup Path to Author_Group.xml
  # @return [String] true or false
  def self.fix_authorgroup(name, email_business, company_name, company_division,
      email, environment, agroup)
    firstname, surname = get_name(name)
    # @note Author Group: Change the default stuff to the present user
    puts 'Replace the default content with the new content from the user
(Authors_Group)'
    add_result('Enter your first name here.', "#{firstname}", agroup)
    add_result('Enter your surname here.', "#{surname}", agroup)
    add_result('Initial creation by publican', 'Initial creation', agroup)

    if environment == 'Work'
      add_result('Enter your email address here.', "#{email_business}", agroup)
      add_result('Enter your organisation\'s name here.', "#{company_name}",
                 agroup)
      add_result('Enter your organisational division here.',
                 "#{company_division}", agroup)
    else
      add_result('Enter your email address here.', "#{email}", agroup)
      add_result('Enter your organisation\'s name here.', '', agroup)
      add_result('Enter your organisational division here.', '', agroup)
    end
  end

  # Method for splitting the name variable into firstname and surname
  # @param [String] name The name from config file
  # @return [String] true or false
  def self.get_name(name)
    namechomp = name.chomp
    # @note Split the variable to the array title[*]
    name = namechomp.split(' ')
    firstname = name[0]
    surname = name[1]
    [firstname, surname]
  end
end
