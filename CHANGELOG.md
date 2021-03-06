### 1.2.4 / 2020-06-27

  * updated dependencies

### 1.2.3 / 2019-05-20

  * Updated dependencies
    * Bump rspec from 3.7.0 to 3.8.0
    * Bump rdoc from 6.0.4 to 6.1.1
    * [Security] Bump nokogiri from 1.8.3 to 1.10.3
    * Bump rubocop from 0.57.2 to 0.68.1

### 1.2.2 / 2018-06-30

#### 1 patch enhancement

  * updated dependencies

### 1.2.1 / 2018-04-29

#### 1 misc enhancement

  * updated dependencies
  * updated documentation and projects url

### 1.2.0 / 2017-11-07

#### 3 minor enhancements

 * updated dependencies
 * code refactoring with rubocop and reek
 * use XDG Standard for config files

### 1.1.2 / 2017-02-27

#### 1 minor enhancement

  * updated dependencies

### 1.1.1 / 2017-02-23

#### 1 minor enhancement

  * updated dependencies

### 1.1.0 / 2016-08-24

#### 1 minor enhancement

  * updated dependencies

#### 1 major enhancement

  * fixed setup (Removed :setup_start from :setup)

### 1.0.4 / 2016-08-06

#### 1 minor enhancement

  * updated dependencies from gemnasium

### 1.0.3 / 2016-02-08

#### 1 minor enhancement

  * updated dependencies from gemnasium

### 1.0.2 / 2016-01-27

#### 1 minor enhancement

  * updated dependencies by gemnasium

### 1.0.1 / 2015-12-23

#### 1 minor enhancement

  * updated dependencies

### 0.4.14 / 2015-12-07

#### 1 minor enhancement

  * fixed URL for openHUB and Openhatch

### 0.4.13 / 2015-09-08

#### 3 minor enhancements

  * fixed PC23 (usage of setup.rb instead of native code).
  * New structure: etc contains the publicancreators.cfg which will installed to HOME/.publican_creators/publicancreators.cfg. Also share/publican_creators contains the pictures for the launchers.
  * Added .index and MANIFEST for packagers

### 0.4.12 / 2015-09-07

#### 1 minor enhancement

  * Added bintray deployment

### 0.4.9 / 2015-06-27

#### 1 minor enhancement

  * Fixed link creater for bins. The old code removes the old link, but doesn't creates a new one.

### 0.4.8.1 / 2015-05-26

#### 2 minor enhancements

  * Improved and extended testcases for continuous integration
  * Improved code to pacify rubocop.

### 0.4.8 / 2015-05-26

#### 1 bug fix

  * fixed  PC-18 Can't use RevisionCreator anymore

### 0.4.7 / 2015-05-25

#### 1 bug fix

  * fixed PC-17 Fix buildscript (Rakefile)

#### 1 cosmetics

  * fixed PC-16 Refactor prepare

### 0.4.6 / 2015-05-23

#### 4 bug fixes

  * fixed PC-15 Cleanup and simplify the codebase
  * fixed Inch CI: revision/f0acc2fd/code_object/1107530
  * fixed Inch CI: revision/f0acc2fd/code_object/1104611
  * fixed Inch CI: revision/f0acc2fd/code_object/1107517

### 0.4.5 / 2015-05-21

#### 2 bug fixes

  * fixed PC-13 Hardcoded language in fix_authorgroup_work
  * fixed PC-14 Refactor fix_authorgroup_work

### 0.4.4 / 2015-05-20

#### 2 bug fixes

  * fixed PC-12 Extend RevisionCreator for changing the version number in Article_Info or Book_Info
  * Updated documentation after fixing PC-12

### 0.4.3 / 2015-05-18

#### 1 cosmetic

  * Updated and improved documentation

### 0.4.2 / 2015-05-16

#### 3 bug fixes

  * Removed require PublicanCreators from RevisonCreator, because otherwise starts PublicanCreators.
  * Fixed get class. Now it's possible to use blanks instead of underscores.
  * Also possible to use blanks instead of underscores in RevisionCreator.

### 0.4.0 / 2015-05-16

#### 1 bug fix

  * Both desktop files from PublicanCreators and RevisionCreators having just the name PublicanCreators. Now PublicanCreators uses its name and RevisionCreators its name.

#### 3 cosmetic

  * Made the shell output more colorful. Used yellow as standard color, red for fails, green for successes and blue for to check things.
  * Extended Rakefile for preparing, building and publishing this gems docs.

### 0.3.6 / 2015-05-15

#### 1 bug fix

  * Fixed Rakefile buildscript issue

### 0.3.5 / 2015-05-15

#### 1 bug fix

  * fixed link_binary_rev (The variable for checker aren't resolved

#### 1 minor enhancement

  * Changed the buildscript from shellscript to Rakefile. A little bit more comfortable.

### 0.3.2 / 2015-05-15

#### 2 bug fixes

  * Readded IRB to binary. Otherwise it doesn't start from /usr/bin (Hotfix)
  * Hotfix for test file

### 0.3.0 / 2015-05-09

#### 3 bug fixes

  * PC-1: Create UI for add_revision
  * PC-4: Create UI (Task)
  * PC-5: Create/Update Documentation (Task)

### 0.2.0 / 2015-05-07

#### 5 bug fixes

  * PC-6: Create rules for setup Fedora
  * PC-7: Fix setup.sh
  * PC-8: Add URL to Bugtracker into UI
  * PC-9: Split methods from module PublicanCreatorsChange
  * PC-10: Config versioning

### 0.1.1 / 2015-05-06

#### 2 minor enhancements

  * Fetches the titlename, type and environment from a yad dialogbox
  * Creates the initial documentation by using publican with using your titlename, your chosen type and environment

#### 2 bug fixes

  * PC-2: Extend documentation A-Type
  * PC-3: Extend documentation B-Type

### 0.1.0  / 2015-04-25

#### 1 major enhancement
  * Build the base functions