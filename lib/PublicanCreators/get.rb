module PublicanCreatorsGet

  def self.get_title
    # Titel erfragen
    titelin = `yad --entry --button="Bestätigen" --title="Neuen Artikel erstellen" --text="Gebe ein Titel ein (Mit Unterstrichen statt Leerzeichen und ohne Umlaute):"`
    $titel = titelin.chomp
  end

  def self.get_article_type
    artin = `yad --title="Artikelart auswählen" --text="Welcher Art ist dein Artikel?" --button="Report" --button="Normale-Dokumentation" --image=/usr/share/pixmaps/publican-xcom.png`
    $art = artin.chomp
  end
end