# PublicanCreators - a Gem für Publican

| What                          | Status                                                                                                                                                                              |
|-------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| license                       | [![license](http://img.shields.io/:license-gpl3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0.html)                                                                                |
| last public version           | [![publicversion](https://badge.fury.io/rb/PublicanCreators.png)](http://rubygems.org/gems/PublicanCreators)                                                                      |
| downloads latest              | [![downloads-latest](https://img.shields.io/gem/dtv/PublicanCreators.svg)](https://rubygems.org/gems/PublicanCreators)                                                            |
| downloads all                 | [![downloads-all](https://img.shields.io/gem/dt/PublicanCreators.svg)](https://rubygems.org/gems/PublicanCreators)                                                                |
| continuous integration        | [![travis](https://secure.travis-ci.org/saigkill/PublicanCreators.png?branch=master)](https://secure.travis-ci.org/saigkill/PublicanCreators)                                     |
| continuous integration        | [![scrutinizer](https://scrutinizer-ci.com/g/saigkill/PublicanCreators/badges/build.png?b=master)](https://scrutinizer-ci.com/g/saigkill/PublicanCreators/build-status/master)   |
| test coverage                 | [![coveralls](https://coveralls.io/repos/saigkill/PublicanCreators/badge.png?branch=master)](https://coveralls.io/r/saigkill/PublicanCreators?branch=master)                      |
| code quality                  | [![codeclimate](https://codeclimate.com/github/saigkill/PublicanCreators.png)](https://codeclimate.com/github/saigkill/PublicanCreators)                                          |
| code quality                  | [![scrutinizer](https://scrutinizer-ci.com/g/saigkill/PublicanCreators/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/saigkill/PublicanCreators/?branch=master) |
| dependency check              | [![gemnasium](https://gemnasium.com/saigkill/PublicanCreators.png)](https://gemnasium.com/saigkill/PublicanCreators)                                                              |
| still maintained?             | [![stillmaintained](http://stillmaintained.com/saigkill/PublicanCreators.png)](http://stillmaintained.com/saigkill/PublicanCreators)                                              |
| documentation quality         | [![documentationquality](http://inch-ci.org/github/saigkill/PublicanCreators.svg?branch=master)](http://inch-ci.org/github/saigkill/PublicanCreators)                             |
| documentation                 | http://www.rubydoc.info/gems/PublicanCreators                                                                                                                                    |
| user documentation            | http://saigkill.github.io/docs/PublicanCreators/en-US/html/                                                                                                                                    |
| Bugreports & Feature requests | http://saigkill-bugs.myjetbrains.com/youtrack/issues                                                                                                                              |
| authors blog                  | http://saigkill.github.io                                                                                                                                                         |
| openhub statistics            | https://www.openhub.net/p/PublicanCreators                                                                                                                                       |
| donations                     | [![pledgie](https://pledgie.com/campaigns/29306.png?skin_name=chrome)](https://pledgie.com/campaigns/29306)                                                                         |
| donations                     | [![gratipay](http://img.shields.io/gratipay/saigkill.svg)](https://gratipay.com/~saigkill/)                                                                                         |
| donations                     | [![amazon](http://tsv-neuss.de/cms/upload/News-Bilder/amazon1.png)](http://www.amazon.de/registry/wishlist/D75HOEQ00BDD)                                                            |

## Description

PublicanCreators are a small tool for daily DocBook writers who are using the Redhat publican tool https://fedorahosted.org/publican/. PublicanCreators asks after
launching which title, type and environment should be used. Then it starts publican with that settings and works then with the produced files.
It will work inside the Article_Info.xml, Book_Info.xml, TITLE.ent, Author_Group.xml and Revision_History.xml and
will replace the default values with your name, your company, your company_divison and your private or your business
email address, depending on your chosen environment. Also you can set inside your config file that you want to remove
the Title Logo or the Legal Notice. As a feature it ships a build script for each project.

## Installation

The installation is very easy.

    gem install PublicanCreators
    gem install rake
    cd /path/to/gem
    rake setup_start

You have to run the setup after each gem update.

## Hard dependencies
* yad
* publican (a 4.x version is needed)

## Soft dependencies
I'm using:

* dir
* fileutils
* nokogiri

Bundler should solve the dependencies by itself.

## Usage

    /path/to/gem/bin/PublicanCreators.rb

Or just use the Launcher.

## Feature Requests & Bug Reports
You can file Requests and Reports on the my bugtracker: http://saigkill-bugs.myjetbrains.com/youtrack/issues.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
