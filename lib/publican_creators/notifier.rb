#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract Notifier Module for latex_curriculum_vitae
#
# Copyright (C) 2015-2016  Sascha Manns <Sascha.Manns@mailbox.org>
# License: MIT

# Dependencies

# Module for notify the user
require 'notifier'

module Notifier
  def self.run
    home = Dir.home
    prefix = "#{home}/.rvm/rubies/default"
    datadir = "#{prefix}/share"
    img = "#{datadir}/.publican_creators/publican.png"
    Notifier.notify(
        :image => "#{img}",
        :title => "Your Documentation",
        :message => "The preparation of your Documentation is finished."
    )
  end
end