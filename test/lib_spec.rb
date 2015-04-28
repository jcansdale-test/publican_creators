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
require File.dirname(__FILE__) + '/spec_helper'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

#Test environment
title = 'The_holy_Bible'
home = Dir.home
#dir = "#{home}/Dokumente/Textdokumente/publican_test/articles"
environment = 'Dienstlich'
type = 'Article'
homework = 'FALSE'
language = 'de-DE'
brand = 'XCOM'
brand_homework = 'ils'
brand_private = 'manns'
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
revhist = "#{title}/de-DE/Revision_History.xml"
agroup = "#{title}/de-DE/Author_Group.xml"
builds = "#{title}/de-DE/build.sh"
brand_dir = '/usr/share/publican/Common_Content/XCOM'
global_entities = "#{brand_dir}/de-DE/entitiesxcom.ent"

describe 'Documentation Creator Work' do
  it 'should change to an directory and creates there an initial documentation' do
    PublicanCreatorsChange.init_docu(title, environment, type, homework, language, brand, brand_homework, brand_private, db5)
    Dir.exist?(title)
    :should == true
  end
end

describe 'Entity Changer' do
  it 'should add the XCOM Entities' do
    PublicanCreatorsChange.add_entity(ent, environment, global_entities, brand)
    f = File.new(ent)
    text = f.read
    true
    if text =~ /XCOM/
      false
    end
    :should == true
  end
end

describe 'Orgname Remover' do
  it 'should remove the Orgname node from the XML file' do
    PublicanCreatorsChange.remove_orgname(artinfo, environment, title_logo)
    f = File.new(artinfo)
    text = f.read
    true
    if text =~ /orgname/
      false
    end
    :should == false
  end
end

describe 'Remove Legalnotice' do
  it 'should remove the Legalnotice from the XML file' do
    PublicanCreatorsChange.remove_legal(artinfo, environment, type, legal)
    f = File.new(artinfo)
    text = f.read
    true
    if text =~ /Legal_Notice/
      false
    end
    :should == false
  end
end

describe 'Fix Revision History' do
  it 'should change names and emailaddresses to the present user' do
    PublicanCreatorsChange.fix_revhist(revhist, environment, name, email_business, email)
    f = File.new(revhist)
    text = f.read
    true
    if text =~ /Sascha.Manns@xcom.de/
      false
    end
    :should == true
  end
end

describe 'Fix Authorgroup' do
  it 'should change the names and emailaaddresses to the present user' do
    PublicanCreatorsChange.fix_authorgroup(agroup, environment, name, email, email_business, company_name, company_division)
    f = File.new(agroup)
    text = f.read
    true
    if text =~ /Sascha.Manns@xcom.de/
      false
    end
    :should == true
  end
end

describe 'Export Buildscript' do
  it 'should export a shellscript with resolved title entity' do
    PublicanCreatorsExport.export_buildscript(title, builds, language)
    File.exist?(builds)
    :should == true
  end
end

describe 'Make executable Buildscript' do
  it 'should make the script executable' do
    File.executable?(builds)
    :should == true
  end
end

describe 'Cleanup' do
  it 'should remove the test directory' do
    FileUtils.rm_rf(title)
    Dir.exist?(title)
    :should == false
  end
end
