# publican_creators

## DESCRIPTION:

publican_creators are a small tool for daily DocBook writers who are using the Redhat publican tool
https://fedorahosted.org/publican/. publican_creators asks after launching which title, type and environment should be
used. Then it starts publican with that settings and works then with the produced files.
It will work on the Article_Info.xml, Book_Info.xml, TITLE.ent, Author_Group.xml and Revision_History.xml and
will replace the default values with your name, your company, your company_divison and your private or your business
email address, depending on your chosen environment. Also, you can set your config file that you want to remove
the Title Logo or the Legal Notice. As a feature, it ships a build script for each project.

The CHANGELOG.md contains a detailed description of what has changed.

hoe-reek is released under the GPL3 License, see the file 'License.rdoc' for more information.

The official website is:

    https://dev.azure.com/saigkill/publican_creators

|What|Where|
|-----|-------------------------------------------------------------------------------------|
|code  | https://dev.azure.com/saigkill/publican_creators |
|docs | https://saigkillsbacktrace.azurewebsites.net/doc-pc |
|apidoc | http://rubydoc.info/gems/publican_creators |
|bugs & feature requests  | https://dev.azure.com/saigkill/publican_creators/_workitems |
|mailing list | https://groups.google.com/forum/#!forum/publican_creators |
|openhub statistics | https://www.openhub.net/p/publicancreators |
|authors blog | http://saschamanns.de |
|min. rubyver | 2.3.0 |

last public version  :: {<img src="https://badge.fury.io/rb/publican_creators.png" alt="Build Status" />}[http://rubygems.org/gems/publican_creators]
downloads latest :: {<img src="https://img.shields.io/gem/dtv/publican_creators.svg" alt="Build Status" />}[http://rubygems.org/gems/publican_creators]
downloads all :: {<img src="https://img.shields.io/gem/dt/publican_creators.svg" alt="Build Status" />}[http://rubygems.org/gems/publican_creators]
continuous integration :: {<img src="https://secure.travis-ci.org/saigkill/publican_creators.png?branch=master" alt="Build Status" />}[https://secure.travis-ci.org/saigkill/publican_creators]
continuous integration :: {<img src="https://scrutinizer-ci.com/g/saigkill/publican_creators/badges/build.png?b=master" />}[https://scrutinizer-ci.com/g/saigkill/publican_creators/]
test coverage :: {<img src="https://coveralls.io/repos/github/saigkill/publican_creators/badge.svg?branch=master" alt="Coverage Status" />}[https://coveralls.io/github/saigkill/publican_creators?branch=master]
code quality :: {<img src="https://scrutinizer-ci.com/g/saigkill/publican_creators/badges/quality-score.png?b=master" />}[https://scrutinizer-ci.com/g/saigkill/publican_creators/]
code quality :: {<img src="https://codeclimate.com/github/saigkill/PublicanCreators/badges/gpa.svg" alt="Code Quality" />}[https://codeclimate.com/github/saigkill/PublicanCreators]
security :: {<img src="https://hakiri.io/github/saigkill/publican_creators/master.svg" alt="security" />}[https://hakiri.io/github/saigkill/publican_creators/master]
documentation quality :: {<img src="http://inch-ci.org/github/saigkill/PublicanCreators.svg?branch=master" alt="Documentation Quality" />}[http://inch-ci.org/github/saigkill/PublicanCreators]

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