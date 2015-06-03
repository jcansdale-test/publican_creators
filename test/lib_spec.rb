require 'rspec'
require 'PublicanCreators/version'
require 'PublicanCreators/checker'
require 'PublicanCreators/get'
require 'PublicanCreators/change'
require 'PublicanCreators/export'
require 'PublicanCreators/create'
require 'PublicanCreators/testlib'
require 'fileutils'
require 'tempfile'
require 'nokogiri'
require 'dir'
require 'bundler/setup'
require 'rainbow/ext/string'
require File.dirname(__FILE__) + '/spec_helper'

describe 'PublicanCreatorsCreate' do
  describe '.init_docu_work' do
    context 'Work (Article)' do
      title = 'The_holy_Bible-WorkArt'
      type = 'Article'
      language = 'de-DE'
      brand = 'XCOM'
      db5 = 'true'
      it 'creates a new set of documentation for Work/Article' do
        PublicanCreatorsCreate.init_docu_work(title, type, language, brand, db5)
        expect(Dir.exist?(title)).equal? 'true'
      end
    end

    context 'Work (Book)' do
      title = 'The_holy_Bible-WorkBook'
      type = 'Book'
      language = 'de-DE'
      brand = 'XCOM'
      db5 = 'true'
      it 'creates a new set of documentation for Work/Book' do
        PublicanCreatorsCreate.init_docu_work(title, type, language, brand, db5)
        expect(Dir.exist?(title)).equal? 'true'
      end
    end
  end

  describe '.init_docu_private' do
    context 'Private (Article)' do
      title = 'The_holy_Bible-PrivArt'
      type = 'Article'
      language = 'de-DE'
      brand_private = 'manns'
      brand_homework = 'ils'
      homework = 'FALSE'
      db5 = 'true'
      it 'creates a new set of documentation for Private/Article' do
        PublicanCreatorsCreate.init_docu_private(title, type, homework,
                                                 language, brand_homework,
                                                 brand_private, db5)
        expect(Dir.exist?(title)).equal? 'true'
      end
    end

    context 'Private (Article/Homework)' do
      title = 'The_holy_Bible-PrivArtHome'
      type = 'Article'
      language = 'de-DE'
      brand_private = 'manns'
      brand_homework = 'ils'
      homework = 'TRUE'
      db5 = 'true'
      it 'creates a new set of documentation for Private/Article/Homework' do
        PublicanCreatorsCreate.init_docu_private(title, type, homework,
                                                 language, brand_homework,
                                                 brand_private, db5)
        expect(Dir.exist?(title)).equal? 'true'
      end
    end

    context 'Private (Book)' do
      title = 'The_holy_Bible-PrivBook'
      type = 'Book'
      language = 'de-DE'
      brand_private = 'manns'
      brand_homework = 'ils'
      homework = 'TRUE'
      db5 = 'true'
      it 'creates a new set of documentation for Private/Book' do
        PublicanCreatorsCreate.init_docu_private(title, type, homework,
                                                 language, brand_homework,
                                                 brand_private, db5)
        expect(Dir.exist?(title)).equal? 'true'
      end
    end
  end
end

describe 'PublicanCreatorsChange' do
  describe '.add_entity' do
    context 'Work Environment (Article) with global_entities variable' do
      environment = 'Work'
      title = 'The_holy_Bible-WorkArt'
      brand_dir = '/usr/share/publican/Common_Content/XCOM'
      global_entities = "#{brand_dir}/de-DE/entitiesxcom.ent"
      ent = "#{title}/de-DE/#{title}.ent"
      pattern = 'COMMON ENTITIES'
      it 'Adds the Entities from the global ent file' do
        PublicanCreatorsChange.add_entity(environment, global_entities, ent)
        result = PublicanCreatorsTest.check_content(ent, pattern)
        expect(result).equal? 'true'
      end
    end

    context 'Work Environment (Book) with global_entities variable' do
      environment = 'Work'
      title = 'The_holy_Bible-WorkBook'
      brand_dir = '/usr/share/publican/Common_Content/XCOM'
      global_entities = "#{brand_dir}/de-DE/entitiesxcom.ent"
      ent = "#{title}/de-DE/#{title}.ent"
      pattern = 'COMMON ENTITIES'
      it 'Adds the Entities from the global ent file' do
        PublicanCreatorsChange.add_entity(environment, global_entities, ent)
        result = PublicanCreatorsTest.check_content(ent, pattern)
        expect(result).equal? 'true'
      end
    end

    context 'Private Environment (Article) without global_entities variable' do
      environment = 'Private'
      global_entities = ''
      title = 'The_holy_Bible-PrivArt'
      ent = "#{title}/de-DE/#{title}.ent"
      pattern = 'COMMON ENTITIES'
      it 'Leaves the local Entityfile blank' do
        PublicanCreatorsChange.add_entity(environment, global_entities, ent)
        result = PublicanCreatorsTest.check_content(ent, pattern)
        expect(result).equal? 'false'
      end
    end

    context 'Private Environment (Book) without global_entities variable' do
      environment = 'Private'
      global_entities = ''
      title = 'The_holy_Bible-PrivBook'
      ent = "#{title}/de-DE/#{title}.ent"
      pattern = 'COMMON ENTITIES'
      it 'Leaves the local Entityfile blank' do
        PublicanCreatorsChange.add_entity(environment, global_entities, ent)
        result = PublicanCreatorsTest.check_content(ent, pattern)
        expect(result).equal? 'false'
      end
    end
  end
end

describe 'PublicanCreatorsChange' do
  describe '.remove_orgname' do
    context 'Work Environment (Article) Without Publicans Title Logo' do
      title = 'The_holy_Bible-WorkArt'
      artinfo = "#{title}/de-DE/Article_Info.xml"
      bookinfo = "#{title}/de-DE/Book_Info.xml"
      title_logo = 'false'
      type = 'Article'
      pattern = 'orgname'
      it 'Removes the title logo' do
        PublicanCreatorsChange.remove_orgname_prepare(bookinfo, artinfo,
                                                      title_logo, type)
        result = PublicanCreatorsTest.check_content(artinfo, pattern)
        expect(result).equal? 'false'
      end
    end

    context 'Work Environment (Book) Without Publicans Title Logo' do
      title = 'The_holy_Bible-WorkBook'
      artinfo = "#{title}/de-DE/Article_Info.xml"
      bookinfo = "#{title}/de-DE/Book_Info.xml"
      title_logo = 'false'
      type = 'Book'
      pattern = 'orgname'
      it 'Removes the title logo' do
        PublicanCreatorsChange.remove_orgname_prepare(bookinfo, artinfo,
                                                      title_logo, type)
        result = PublicanCreatorsTest.check_content(bookinfo, pattern)
        expect(result).equal? 'false'
      end
    end

    context 'With Publicans Title Logo' do
      title = 'The_holy_Bible-PrivArt'
      artinfo = "#{title}/de-DE/Article_Info.xml"
      bookinfo = "#{title}/de-DE/Book_Info.xml"
      title_logo = 'true'
      type = 'Article'
      pattern = 'orgname'
      it 'Removes not the title logo' do
        PublicanCreatorsChange.remove_orgname_prepare(bookinfo, artinfo,
                                                      title_logo, type)
        result = PublicanCreatorsTest.check_content(artinfo, pattern)
        expect(result).equal? 'true'
      end
    end

    context 'With Publicans Title Logo' do
      title = 'The_holy_Bible-PrivBook'
      artinfo = "#{title}/de-DE/Article_Info.xml"
      bookinfo = "#{title}/de-DE/Book_Info.xml"
      title_logo = 'true'
      type = 'Book'
      pattern = 'orgname'
      it 'Removes not the title logo' do
        PublicanCreatorsChange.remove_orgname_prepare(bookinfo, artinfo,
                                                      title_logo, type)
        result = PublicanCreatorsTest.check_content(bookinfo, pattern)
        expect(result).equal? 'true'
      end
    end
  end
end

describe 'PublicanCreatorsChange' do
  describe '.remove_legal' do
    context 'Work (Article) Without Legalnotice' do
      type = 'Article'
      legal = 'true'
      environment = 'Work'
      title = 'The_holy_Bible-WorkArt'
      artinfo = "#{title}/de-DE/Article_Info.xml"
      pattern = '<xi:include href="Common_Content/
Legal_Notice.xml" xmlns:xi="http://www.w3.org/2001/XInclude" />'
      it 'removes the Legalnotice from the XML file' do
        PublicanCreatorsChange.remove_legal(environment, type, legal, artinfo)
        result = PublicanCreatorsTest.check_content(artinfo, pattern)
        expect(result).equal? 'false'
      end
    end

    context 'Work (Book) Without Legalnotice' do
      type = 'Book'
      legal = 'true'
      environment = 'Work'
      title = 'The_holy_Bible-WorkBook'
      bookinfo = "#{title}/de-DE/Book_Info.xml"
      pattern = '<xi:include href="Common_Content/
Legal_Notice.xml" xmlns:xi="http://www.w3.org/2001/XInclude" />'
      it 'removes the Legalnotice from the XML file' do
        PublicanCreatorsChange.remove_legal(environment, type, legal, bookinfo)
        result = PublicanCreatorsTest.check_content(bookinfo, pattern)
        expect(result).equal? 'true'
      end
    end

    context 'With Legalnotice inside the XML file' do
      type = 'Article'
      legal = 'false'
      environment = 'Private'
      title = 'The_holy_Bible-PrivArt'
      artinfo = "#{title}/de-DE/Article_Info.xml"
      pattern = '<xi:include href="Common_Content/
Legal_Notice.xml" xmlns:xi="http://www.w3.org/2001/XInclude" />'
      it 'removes the Legalnotice from the XML file' do
        PublicanCreatorsChange.remove_legal(environment, type, legal, artinfo)
        result = PublicanCreatorsTest.check_content(artinfo, pattern)
        expect(result).equal? 'true'
      end
    end

    context 'With Legalnotice inside the XML file' do
      type = 'Book'
      legal = 'false'
      environment = 'Private'
      title = 'The_holy_Bible-PrivBook'
      bookinfo = "#{title}/de-DE/Book_Info.xml"
      pattern = '<xi:include href="Common_Content/
Legal_Notice.xml" xmlns:xi="http://www.w3.org/2001/XInclude" />'
      it 'removes the Legalnotice from the XML file' do
        PublicanCreatorsChange.remove_legal(environment, type, legal, bookinfo)
        result = PublicanCreatorsTest.check_content(bookinfo, pattern)
        expect(result).equal? 'true'
      end
    end
  end
end


describe 'PublicanCreatorsChange' do
  describe '.fix_revhist' do
    context 'Work Environment' do
      environment = 'Work'
      name = 'Sascha Manns'
      firstname = 'Sascha'
      surname = 'Manns'
      email = 'Sascha.Manns@bdvb.de'
      email_business = 'Sascha.Manns@xcom.de'
      title = 'The_holy_Bible-WorkArt'
      revhist = "#{title}/de-DE/Revision_History.xml"
      it 'Updates the revision history in Work context' do
        PublicanCreatorsChange.fix_revhist(environment, name, email_business,
                                           email, revhist)
        [firstname, surname, email_business].each do |pattern|
          result = PublicanCreatorsTest.check_content(revhist, pattern)
          expect(result).equal? 'true'
        end
      end
    end

    context 'Private Environment' do
      environment = 'Private'
      name = 'Sascha Manns'
      firstname = 'Sascha'
      surname = 'Manns'
      email = 'Sascha.Manns@bdvb.de'
      email_business = 'Sascha.Manns@xcom.de'
      title = 'The_holy_Bible-PrivArt'
      revhist = "#{title}/de-DE/Revision_History.xml"
      it 'updates the revision history to Private context' do
        PublicanCreatorsChange.fix_revhist(environment, name, email_business,
                                           email, revhist)
        [firstname, surname, email_business].each do |pattern|
          result = PublicanCreatorsTest.check_content(revhist, pattern)
          expect(result).equal? 'true'
        end
      end
    end
  end
end

describe 'PublicanCreatorsChange' do
  describe '.fix_authorgroup' do
    context 'Work' do
      email_business = 'Sascha.Manns@xcom.de'
      name = 'Sascha Manns'
      firstname = 'Sascha'
      surname = 'Manns'
      company_name = 'XCOM AG'
      company_division = 'SWE7'
      email = 'Sascha.Manns@xcom.de'
      environment = 'Work'
      title = 'The_holy_Bible-WorkArt'
      agroup = "#{title}/de-DE/Author_Group.xml"
      it 'Updates Authorgroup in Work context' do
        PublicanCreatorsChange.fix_authorgroup(name, email_business,
                                               company_name, company_division,
                                               email, environment, agroup)
        [firstname, surname, email_business, company_name,
         company_division].each do |pattern|
          result = PublicanCreatorsTest.check_content(agroup, pattern)
          expect(result).equal? 'true'
        end
      end
    end

    context 'Private' do
      email_business = 'Sascha.Manns@xcom.de'
      name = 'Sascha Manns'
      firstname = 'Sascha'
      surname = 'Manns'
      company_name = 'XCOM AG'
      company_division = 'SWE7'
      email = 'Sascha.Manns@bdvb.de'
      environment = 'Private'
      title = 'The_holy_Bible-PrivArt'
      agroup = "#{title}/de-DE/Author_Group.xml"
      it 'Updates Authorgroup in Work context' do
        PublicanCreatorsChange.fix_authorgroup(name, email_business,
                                               company_name, company_division,
                                               email, environment, agroup)
        [firstname, surname, email].each do |pattern|
          result = PublicanCreatorsTest.check_content(agroup, pattern)
          expect(result).equal? 'true'
        end
      end
    end
  end
end

describe 'PublicanCreatorsExport' do
  describe '.export_buildscript' do
    context 'Default'
    title = 'The_holy_Bible-WorkArt'
    builds = "#{title}/de-DE/Rakefile"
    language = 'de-DE'
    xfc_brand_dir = '/opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl'
    pdfview = '/opt/cxoffice/bin/wine --bottle "PDF-XChange Viewer 2.x" --cx-app
PDFXCview.exe'
    it 'exports a shellscript with resolved title entity' do
      PublicanCreatorsExport.export_buildscript(title, builds, language,
                                                xfc_brand_dir, pdfview)
      File.exist?(builds)
      PublicanCreatorsTest.check_content(builds, xfc_brand_dir)
      :expect == true
    end
  end
end

describe 'PublicanCreatorsTest' do
  describe '.cleanup' do
    it 'cleans up the test directory' do
      PublicanCreatorsTest.cleanup
      File.exist?('The_holy_Bible-PrivArt')
      File.exist?('The_holy_Bible-PrivArtHome')
      File.exist?('The_holy_Bible-PrivArtBook')
      File.exist?('The_holy_Bible-WorkArt')
      File.exist?('The_holy_Bible-WorkBook')
      :expect == 'false'
    end
  end
end

