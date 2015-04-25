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
require 'rainbow/ext/string'
require 'bundler/setup'
require File.dirname(__FILE__) + '/spec_helper'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

#Test environment
title = 'The_holy_Bible'
home = Dir.home
dir = "#{home}/Dokumente/Textdokumente/publican_test/articles"
environment = 'Dienstlich'
type = 'Artikel'
ils = 'FALSE'
ent = "#{titel}/de-DE/#{titel}.ent"
artinfo = "#{titel}/de-DE/Article_Info.xml"
revhist = "#{titel}/de-DE/Revision_History.xml"
agroup = "#{titel}/de-DE/Author_Group.xml"
builds = "#{titel}/de-DE/build.sh"
globalentities = "#{brand_dir}/de-DE/entitiesxcom.ent"

describe 'Documentation Creator Work' do
  it 'should change to an directory and creates there an initial documentation' do
    PublicanCreatorsChange.init_docu(title, environment, type, ils)
    Dir.exist?(title)
    :should == true
  end
end

describe 'Entity Changer' do
  it 'should add the XCOM Entities' do
    PublicanCreatorsChange.add_entity(ent, environment, globalentities)
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
    PublicanCreatorsChange.remove_orgname(artinfo, environment)
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
    PublicanCreatorsChange.remove_legal(artinfo, environment, type)
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
    PublicanCreatorsChange.fix_revhist(revhist, environment)
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
    PublicanCreatorsChange.fix_authorgroup(agroup, environment)
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
    PublicanCreatorsExport.export_buildscript(title, builds)
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
