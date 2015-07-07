# PublicanCreatorsVersion
# @author Sascha Manns
# @abstract Class for maintaining the version number
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: GPL-3

# Method for versioning the gem
class PublicanCreatorsVersion
  # @note human readable Version
  # @return [String] STRING (Version)
  module Version
    # Major version. Maybe never reached
    MAJOR = 0
    # Minor version.
    MINOR = 4
    # Patchlevel
    PATCH = 11
    # Buildversion. Mostly 0
    BUILD = 0
    # @note This will be shown by PublicanCreatorsVersion::Version::STRING
    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')
  end
end
