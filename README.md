# publican_creators

## DESCRIPTION:

publican_creators are a small tool for daily DocBook writers who are using the Redhat publican tool
https://fedorahosted.org/publican/. 

publican_creators provides a simple gui for creating new DocBook stuff. It supports different environments, so you can predefine currently
three environments (like work, home, home2) and work with them. You also can build to different output targets through
the shipped Buildscript.

The CHANGELOG.md contains a detailed description of what has changed.

hoe-reek is released under the GPL3 License, see the file 'LICENSE.md' for more information.

The official website is:

    https://github.com/saigkill/publican_creators

|What|Where|
|-----|-------------------------------------------------------------------------------------|
|code  | https://github.com/saigkill/publican_creators |
|docs | https://saschamanns.de/docs/publican_creators/index.html |
|apidoc | http://rubydoc.info/gems/publican_creators |
|bugs & feature requests  | https://github.com/saigkill/publican_creators/issues |
|mailing list | https://groups.google.com/forum/#!forum/publican_creators |
|openhub statistics | https://www.openhub.net/p/publicancreators |
|authors blog | https://saschamanns.de |
|min. rubyver | 2.3.0 |

| What | Status |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|last public version | [![Last Version](https://badge.fury.io/rb/publican_creators.png)](http://rubygems.org/gems/publican_creators) |
|downloads latest | [![Downloads latest](https://img.shields.io/gem/dtv/publican_creators.svg)](http://rubygems.org/gems/publican_creators)  |
|downloads all | [![Downloads all](https://img.shields.io/gem/dt/publican_creators.svg)](http://rubygems.org/gems/publican_creators) |
|code quality | [![Maintainability](https://api.codeclimate.com/v1/badges/e6e62c135374e4c9e495/maintainability)](https://codeclimate.com/github/saigkill/publican_creators/maintainability) |
|continuous integration | [![Build Status](https://dev.azure.com/saigkill/publican_creators/_apis/build/status/publican_creators-CI?branchName=master)](https://dev.azure.com/saigkill/publican_creators/_build/latest?definitionId=11&branchName=master) |
|dependencies|[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=saigkill/publican_creators)](https://dependabot.com) |
|security | [![Security](https://hakiri.io/github/saigkill/publican_creators/master.svg)](https://hakiri.io/github/saigkill/publican_creators/master/shield) |
|vulnerabilities|[![Known Vulnerabilities](https://snyk.io/test/github/saigkill/publican_creators/badge.svg?targetFile=Gemfile.lock)](https://snyk.io/test/github/saigkill/publican_creators?targetFile=Gemfile.lock) | 
|documentation quality | [![Documentation Quality](https://inch-ci.org/github/saigkill/publican_creators.svg?branch=master)](https://inch-ci.org/github/saigkill/publican_creators) |


## SCREENSHOT

### Main
[![Screenshot](https://saschamanns.de//img/screenshots/PublicanCreators.png)](https://github.com/saigkill/publican_creators)

### Revision Creator
[![Screenshot](https://saschamanns.de//img/screenshots/RevisionCreator.png)](https://github.com/saigkill/publican_creators)

## FEATURES/PROBLEMS:

* GUI to control publican

## SYNOPSIS:

    $ publican_creators.rb (Main program)
    $ revision_creator.rb (The revision updater)

    Or just use the Launcher.

This Gem was programmed and tested on Linux systems. If anyone would like to make the methods also fit for other OS,
I'm happy about Pull requests.

## REQUIREMENTS:

* nokogiri
* parseconfig
* rainbow
* notifier

## REQUIREMENTS (hard dependencies):

* yad
* publican (a 4.x version is needed)

## INSTALL:

The installation is very easy.

    gem install publican_creators
    cd /path/to/gem (In case of using RVM ~/.rvm/gems/ruby-$RUBYVERSION/gems/publican_creators)
    rake

You have to run the setup after each gem update.

## DEVELOPERS:

After checking out the source, run:

    $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.