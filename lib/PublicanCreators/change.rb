require 'nokogiri'
require 'dir'
require 'PublicanCreators/checker'

module PublicanCreatorsChange

  def self.init_doku(titel, umgebung, typ, ils)
    if umgebung == 'Dienstlich'
      if typ == 'Artikel'
        # Erstellung der Initialdokumentation mit Publican
        puts 'Erstelle Initialdokumentation ...'
        system("publican create --lang de-DE --brand XCOM --type Article --dtdver 5.0 --name #{titel}")
      else
        # Erstellung der Initialdokumentation mit Publican
        puts 'Erstelle Initialdokumentation ...'
        system("publican create --lang de-DE --brand XCOM --dtdver 5.0 --name #{titel}")
      end
    else
      if typ == 'Artikel'
        # Erstellung der Initialdokumentation mit Publican
        if ils == 'FALSE'
          puts 'Erstelle Initialdokumentation ...'
          system("publican create --lang de-DE --brand manns --type Article --dtdver 5.0 --name #{titel}")
        else
          puts 'Erstelle Initialdokumentation ...'
          system("publican create --lang de-DE --brand ils --type Article --dtdver 5.0 --name #{titel}")
        end
      else
        # Erstellung der Initialdokumentation mit Publican
        puts 'Erstelle Initialdokumentation ...'
        system("publican create --lang de-DE --brand manns --dtdver 5.0 --name #{titel}")
      end
    end
    if Dir.exist?(titel)
      puts 'Erstellt...'
    else
      raise('Konnte Dokumentation nicht anlegen...')
    end
  end

  def self.add_entity(ent, umgebung)
    if umgebung == 'Dienstlich'
      xcom_brand_dir = '/usr/share/publican/Common_Content/XCOM'
      puts 'Füge globale XCOM Entities hinzu'
      # Globale Entitäten hinzufügen
      open(ent, 'a') { |f|
        f << "\n"
        f << "<!-- XCOM COMMON ENTITIES -->\n"
      }
      input = File.open("#{xcom_brand_dir}/de-DE/entitiesxcom.ent")
      data_to_copy = input.read()
      output = File.open(ent, 'a')
      output.write(data_to_copy)
      input.close
      output.close
    else
      puts 'Nothing to do'
    end
  end

  def self.change_holder(titel, ent, umgebung)
    # Holder ersetzen
    puts 'Ersetze Standardtext durch richtigen Holder'
    if umgebung == 'Dienstlich'
      text = File.read(ent)
      new_contents = text.gsub("| You need to change the HOLDER entity in the de-DE/#{titel}.ent file |", "XCOM AG")
      puts new_contents
      File.open(ent, 'w') { |file| file.puts new_contents }
    else
      text = File.read(ent)
      new_contents = text.gsub("| You need to change the HOLDER entity in the de-DE/#{titel}.ent file |", "Sascha Manns")
      puts new_contents
      File.open(ent, 'w') { |file| file.puts new_contents }
    end
  end

  def self.remove_orgname(artinfo, umgebung)
    # Entferne $titelbild des Artikels
    if umgebung == 'Dienstlich'
      puts 'Entferne Logo aus dem Article_Info File. Wird anders gesetzt.'
      doc = Nokogiri::XML(IO.read(artinfo))
      doc.search('orgname').each do |node|
        node.remove
        node.content = 'Children removed'
      end
      IO.write(artinfo, doc.to_xml)
    else
      puts 'Nothing to do'
    end

  end

  def self.remove_legal(artinfo, umgebung, typ)
    if umgebung == 'Dienstlich'
      if typ == 'Artikel'
        # Entferne Legal Notice wir nutzen eine andere
        puts 'Entferne Link zur Legalnotice, da wir sie anders einbinden'
        text = File.read(artinfo)
        new_contents = text.gsub('<xi:include href="Common_Content/Legal_Notice.xml" xmlns:xi="http://www.w3.org/2001/XInclude" />', '<!-- removed legal -->')
        puts new_contents
        File.open(artinfo, 'w') { |file| file.puts new_contents }
      else
        puts 'Nothing to do'
      end
    else
      puts 'Nothing to do'
    end

  end

  def self.fix_revhist(revhist, umgebung)
    # Revision_History: Ändere vorbelegte Daten
    puts 'Ersetze Standarduser in Revision_History mit dem tatsächlichen'
    text = File.read(revhist)
    vorname = text.gsub('Enter your first name here.', 'Sascha')
    puts vorname
    File.open(revhist, 'w') { |file|
      file.puts vorname
    }
    text = File.read(revhist)
    nachname = text.gsub('Enter your surname here.', 'Manns')
    puts nachname
    File.open(revhist, 'w') { |file|
      file.puts nachname
    }
    text = File.read(revhist)
    if umgebung == 'Dienstlich'
      email = text.gsub('Enter your email address here.', 'Sascha.Manns@xcom.de')
    else
      email = text.gsub('Enter your email address here.', 'Sascha.Manns@bdvb.de')
    end
    puts email
    File.open(revhist, 'w') { |file|
      file.puts email
    }
    text = File.read(revhist)
    member = text.gsub('Initial creation by publican', 'Initial creation')
    puts member
    File.open(revhist, 'w') { |file|
      file.puts member
    }
  end

  def self.fix_authorgroup(agroup, umgebung)
    # Author Group: Ändere vorbelegte Daten
    puts 'Ersetze Standarduser in Author_Group mit dem tatsächlichen'
    text = File.read(agroup)
    vorname = text.gsub('Enter your first name here.', 'Sascha')
    puts vorname
    File.open(agroup, 'w') { |file|
      file.puts vorname
    }
    text = File.read(agroup)
    nachname = text.gsub('Enter your surname here.', 'Manns')
    puts nachname
    File.open(agroup, 'w') { |file|
      file.puts nachname
    }
    text = File.read(agroup)
    if umgebung == 'Dienstlich'
      email = text.gsub('Enter your email address here.', 'Sascha.Manns@xcom.de')
    else
      email = text.gsub('Enter your email address here.', 'Sascha.Manns@bdvb.de')
    end
    puts email
    File.open(agroup, 'w') { |file|
      file.puts email
    }
    text = File.read(agroup)
    member = text.gsub('Initial creation by publican', 'Initial creation')
    puts member
    File.open(agroup, 'w') { |file|
      file.puts member
    }
    text = File.read(agroup)
    if umgebung == 'Dienstlich'
      org = text.gsub('Enter your organisation\'s name here.', 'XCOM AG')
    else
      org = text.gsub('Enter your organisation\'s name here.', '')
    end
    puts org
    File.open(agroup, 'w') { |file|
      file.puts org
    }
    text = File.read(agroup)
    if umgebung == 'Dienstlich'
      div = text.gsub('Enter your organisational division here.', 'SWE 7 (Sascha Bochartz)')
    else
      div = text.gsub('Enter your organisational division here.', '')
    end
    puts div
    File.open(agroup, 'w') { |file|
      file.puts div
    }
  end

  def self.make_buildscript_exe(builds)
    # Buildscript ausführbar machen
    puts 'Mache Buildscript ausführbar ...'
    FileUtils.chmod 'u=rwx,go=rwx', "#{builds}"
  end
end