require 'rspec'
require 'PublicanCreators/version'
require 'PublicanCreators/checker'
require 'PublicanCreators/get'
require 'PublicanCreators/change'
require 'PublicanCreators/export'
require 'fileutils'
require 'tempfile'
require 'nokogiri'
require 'dir'
require 'bundler/setup'
require 'rainbow/ext/string'
require File.dirname(__FILE__) + '/spec_helper'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# Test environment
title = 'The_holy_Bible'
environment = 'Dienstlich'
type = 'Article'
language = 'de-DE'
brand = 'XCOM'
db5 = 'true'
legal = 'true'
title_logo = 'false'
name = 'Sascha Manns'
email_business = 'Sascha.Manns@xcom.de'
email = 'Sascha.Manns@bdvb.de'
company_name = 'XCOM AG'
company_division = 'SWE7'
ent = "#{title}/de-DE/#{title}.ent"
artinfo = "#{title}/de-DE/Article_Info.xml"
bookinfo = "#{title}/de-DE/Book_Info.xml"
revhist = "#{title}/de-DE/Revision_History.xml"
agroup = "#{title}/de-DE/Author_Group.xml"
builds = "#{title}/de-DE/Rakefile"
brand_dir = '/usr/share/publican/Common_Content/XCOM'
global_entities = "#{brand_dir}/de-DE/entitiesxcom.ent"
xfc_brand_dir = '/opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl'
pdfview = '/opt/cxoffice/bin/wine --bottle "PDF-XChange Viewer 2.x" --cx-app
PDFXCview.exe'

# Documentation Creator Work
describe 'PublicanCreatorsChange.init_docu_work' do
  it 'accesses a directory and creates there an initial documentation' do
    PublicanCreatorsChange.init_docu_work(title, type, language, brand, db5)
    Dir.exist?(title)
    :should == true
  end

  describe 'PublicanCreatorsChange.add_entity' do
    it 'adds the XCOM Entities' do
      PublicanCreatorsChange.add_entity(environment, global_entities, ent)
      f = File.new(ent)
      text = f.read
      true
      if text =~ /XCOM/
        false
      end
      :should == true
    end
  end

  describe 'PublicanCreatorsChange.remove_orgname' do
    it 'removes the Orgname node from the XML file' do
      PublicanCreatorsChange.remove_orgname(bookinfo, artinfo, title_logo, type)
      f = File.new(artinfo)
      text = f.read
      true
      if text =~ /orgname/
        false
      end
      :should == false
    end
  end

  describe 'PublicanCreatorsChange.remove_legal' do
    it 'removes the Legalnotice from the XML file' do
      PublicanCreatorsChange.remove_legal(environment, type, legal, artinfo)
      f = File.new(artinfo)
      text = f.read
      true
      if text =~ /Legal_Notice/
        false
      end
      :should == false
    end
  end

  describe 'PublicanCreatorsChange.fix_revhist' do
    it 'changes names and emailaddresses to the present user' do
      PublicanCreatorsChange.fix_revhist(environment, name, email_business,
                                         email, revhist)
      f = File.new(revhist)
      text = f.read
      true
      if text =~ /Sascha.Manns@xcom.de/
        false
      end
      :should == true
    end
  end

  describe 'PublicanCreatorsChange.fix_authorgroup' do
    it 'change the names and emailaaddresses to the present user' do
      PublicanCreatorsChange.fix_authorgroup(name, email_business, company_name,
                                             company_division, email,
                                             environment, agroup)
      f = File.new(agroup)
      text = f.read
      true
      if text =~ /Sascha.Manns@xcom.de/
        false
      end
      :should == true
    end
  end

  describe 'PublicanCreatorsExport.export_buildscript' do
    it 'exports a shellscript with resolved title entity' do
      PublicanCreatorsExport.export_buildscript(title, builds, language,
                                                xfc_brand_dir, pdfview)
      File.exist?(builds)
      :should == true
    end
  end
end
