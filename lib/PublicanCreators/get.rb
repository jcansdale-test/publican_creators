module PublicanCreatorsGet

  def self.get_title
    # Titel erfragen
    #titelin = `yad --entry --button="Bestätigen" --title="Neuen Artikel erstellen" --text="Gebe ein Titel ein (Mit Unterstrichen statt Leerzeichen und ohne Umlaute):"`
    titelin = `yad --title="Dokumentation erstellen" --center --on-top --form --item-separator=, --separator=" "  --field="Umgebung:CBE" --field="Typ:CBE" --field="Optional:CBE" --field="Gebe ein Titel ein (Mit Unterstrichen statt Leerzeichen und ohne Umlaute):TEXT" --button="Go!" "Dienstlich,Privat" "Artikel,Buch" "Normal,Report,ILS"`
    # Format: Dienstlich/Privat!Artikel/Buch!Titel!TRUE/FALSE!TRUE/FALSE
    titelchomp = titelin.chomp
    titel = titelchomp.split(' ')
  end
end