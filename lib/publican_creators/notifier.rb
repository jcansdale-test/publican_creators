# Copyright (C) 2013-2020 Sascha Manns <Sascha.Manns@outlook.de>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Dependencies
require 'notifier'
require 'xdg'

# Module for notify the user
module Notifier
  def self.run
    xdg = XDG::Environment.new
    data_xdg = xdg.data_home
    install_path = "#{data_xdg}/icons/"
    img = "#{install_path}/publican.png"
    Notifier.notify(
      image: img.to_s,
      title: 'Your Documentation',
      message: 'The preparation of your Documentation is finished.'
    )
  end
end
