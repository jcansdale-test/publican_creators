# PublicanCreatorsVersion
# @author Sascha Manns
# @abstract Class for maintaining the version number
#
# Copyright (C) 2015  Sascha Manns <Sascha.Manns@bdvb.de>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:#
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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
    PATCH = 7
    # Buildversion. Mostly 0
    BUILD = 0
    # @note This will be shown by PublicanCreatorsVersion::Version::STRING
    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')
  end
end
