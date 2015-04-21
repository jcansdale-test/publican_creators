module PublicanCreatorsGet

  def self.get_title
    # Titel erfragen
    #titelin = `yad --entry --button="Bestätigen" --title="Neuen Artikel erstellen" --text="Gebe ein Titel ein (Mit Unterstrichen statt Leerzeichen und ohne Umlaute):"`
    titelin = `yad --title="Dokumentation erstellen" --form --item-separator=, --separator=" " --field="Gebe ein Titel ein (Mit Unterstrichen statt Leerzeichen und ohne Umlaute):RO" --field="Eingabefeld:TEXT" --field="Report-Dokumentation:CHK" --field="Ist es ein Buch:CHK" --button="Go!"`
    # Format: _Titel_FALSE_FALSE
    titelchomp = titelin.chomp
    titel = titelchomp.split(' ')
  end
end