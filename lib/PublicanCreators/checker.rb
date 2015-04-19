require 'dir'
require 'fileutils'

module Checker

  # Checks if the targetdirectory are present. If not, it creates one
  def self.check_dir
    # Checking if dir exists
    if Dir.exist?("#{$todo}")
      puts 'Found directory. Im using it.'
    else
      puts 'No directory found. Im creating it.'
      # Creates the new directory
      FileUtils.mkdir_p("#{$todo}")
        if Dir.exist?("#{$todo}")
          puts 'Created new directory...'
        else
          raise('Cant create directory')
        end
    end
  end

end