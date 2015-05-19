��    %      D  5   l      @  g   A  �   �  �   7     �  O     C   T  H   �  ?   �  �   !  �   �  �   �  �   �  t   F	  �   �	  [  �
  �        �     �     �     �  �   [  �     Q   �  �  �     �  o   �  �   *  +   �     "  $   A  /   f    �  �   �  J   !     l  �   �  (  "  n   K  �   �  �   D     �  R     F   a  >   �  I   �  �   1  �   �     �  �   �  �   �           �   9           &      8   �   D   W   �   �   C!  e   �!  `  b"  	   �#  �   �#  �   _$  &   J%  &   q%  '   �%  &   �%    �%  �   �&  S   �'  *   �'  �   
(                                                  %   #                                                                              !              "   	          $      
               <command>rake check_config</command>: It adds the present <command>.publicancreators.cfg.new</command>. <command>rake create_desktop_cre</command> and <command>rake create_desktop_rev</command>: It updates your old desktop files to the new path. <command>rake link_binary_cre</command> and <command>rake link_binary_rev</command>: That is not regular needed. You can launch this, if you use the binaries from /usr/bin. <primary>Introduction</primary> <primary>Introduction</primary> <secondary>Install PublicanCreators</secondary> <primary>Introduction</primary> <secondary>Install Ruby</secondary> <primary>Introduction</primary> <secondary>Running the setup</secondary> A <command>ruby --version</command> should output your version: Before you can start you must check if you have installed Ruby. To do this you can type in a console: <command>ruby --version</command>. The output can be similar to that one: For installing PublicanCreators you now have to type in the console:<command>gem install PublicanCreators</command>. This command solves the soft-dependencies of the program. The output looks similar that one: For running the setup go to the gem's directory with <command>.rvm/gems/ruby-<replaceable>2.2.1</replaceable>/gems/PublicanCreators-<replaceable>&pcver;</replaceable></command>. Then just type <command>rake setup_start</command>. If there are no ruby inside the output you have to go to <xref linkend="install-ruby" />. Otherwise you can skip that step and go to <xref linkend="install-pubcre" />.<emphasis></emphasis> If this command fails, you have to install the <package>curl</package> package. Use your package manager to do this. If you aren't have a old .publicancreators.cfg the setup copies a actual version in your Homedirectory and will launch a Texteditor with the config loaded. So you can modify it to your needs. The config file will be explained in the next chapter. If you have already a <filename>.publicancreators.cfg</filename> in your Homedirectory it will add the actual shipped <filename>.publicancreators.cfg</filename> as .publicancreators.cfg.new in your Homedirectory. You have to check, if new parameters are added or depreached one are there. So modify your old .publicancreators to match the new one. If you have an older version of PublicanCreators, you can run the full <command>rake setup_start</command> or you can just use the following steps: Installing PublicanCreators Installing Ruby Introduction It checks on which host os (Linux) it runs. Then it reacts to that and tried to install the hard dependencies yad and publican. Keep in mind, that the 2.2.1 from ruby-2.2.1 must match your chosen version. Also you have to replace <replaceable>&pcver;</replaceable> with the installed version of PublicanCreators. Now type: <command>rvm install <replaceable>2.2.1</replaceable></command>. If any later ruby than you can replace the 2.2.1 with the newer version. One of the easiest way to install ruby is by using RVM. So follow the next steps: PublicanCreators needs a 4.x version of publican because it uses the parameter <quote>--dtdver</quote>. In case of a Ubuntu host os the setup adds a Launchpad PPA which provides backported versions of publican 4.x for Trusty (14.04) and Utopic (14.10). Vivid Velvet ships a usable publican 4.x version. For other Distributions you have to check if a 4.x version is available for your os. Otherwise PublicanCreators will NOT work. Running the setup The installation can takes some time, because some of the dependencies must compiled natively on your computer. The last thing in the setup is to install two *.desktop files for PublicanCreators and RevisionCreator in <filename>.local/share/applications</filename>. This means it will shown in the program launcher. The output should like similar to that one: The output shows similar that: The setup script does the following: The whole setup process looks like that output: To use RVM you have two options. First you can logout yourself and login again. The other option is just to type: <command>source /home/<replaceable>sascha</replaceable>/.rvm/scripts/rvm</command>. Instead of <quote>sascha</quote> you have to place your username. Type in your console: <command>gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3</command> Type now: <command>curl -sSL https://get.rvm.io | bash -s stable</command> Update from a older version You installed now Ruby (hopefully) without troubles. For further information about RVM you can visit this <link xlink:href="https://rvm.io/">link</link>. Project-Id-Version: 0
POT-Creation-Date: 2015-05-12 20:15+0200
PO-Revision-Date: 2015-05-19 18:31+0100
Last-Translator: Automatically generated
Language-Team: None
Language: en_US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 1.7.5
 <command>rake check_config</command>: Dies installiert eine neue <command>.publicancreators.cfg.new</command>. <command>rake create_desktop_cre</command> and <command>rake create_desktop_rev</command>: Dies aktualisier den Pfad Ihrer Desktop Files. <command>rake link_binary_cre</command> and <command>rake link_binary_rev</command>: Wenn Sie die Links nach /usr/bin nutzen, dann können Sie diese hiermit aktualisieren. <primary>Einleitung</primary> <primary>Einleitung</primary> <secondary>PublicanCreators installieren</secondary> <primary>Einleitung</primary> <secondary>Ruby installieren</secondary> <primary>Einleitung</primary> <secondary>Das Setup</secondary> Ein <command>ruby --version</command> sollte jetzt eine Version ausgeben. Bevor es losgeht, müssen Sie herausfinden, ob Sie Ruby bereits installiert haben. Dazu schreiben Sie in der Konsole: <command>ruby --version</command>. Der Output sollte in etwa so aussehen: Um PublicanCreators zu installieren, geben Sie folgendes in der Konsole ein: <command>gem install PublicanCreators</command>. Dieses Kommando löst alle Soft-Abhängigkeiten auf. Der Outpus sollte in etwa so aussehen: Um das Setup auszuführen, wechseln Sie in das Verzeichnis des Gems mit <command>.rvm/gems/ruby-<replaceable>2.2.1</replaceable>/gems/PublicanCreators-<replaceable>&pcver;</replaceable>/bin</command>. Hier geben Sie <command>rake setup_start</command> ein. Falls das Ergebis fehlschlägt, können Sie hier weitermachen: <xref linkend="install-ruby" />. Andernfalls können Sie hierhin springen: <xref linkend="install-pubcre" />.<emphasis></emphasis> Falls das letzte Kommando fehlschlägt, müssen Sie das Paket <package>curl</package> nachinstallieren. Nutzen Sie dazu Ihren Paketmanager. Falls Sie keine ältere Version der .publicancreators.cfg haben, wird die aktuelle in Ihr Benutzerverzeichnis kopiert, und in einem Texteditor geladen. Dort können Sie Ihre Anpassungen vornehmen. Die Konfigurationsdatei wird im nächsten Kapitel erklärt. Falls Sie bereits ein Konfigurationsfile <filename>.publicancreators.cfg</filename> betreiben, wird die aktuelle <filename>.publicancreators.cfg</filename> als .publicancreators.cfg.new abgespeichert. Nun müssen Sie lediglich die geänderten Parameter in Ihr "altes" File übertragen. Wenn Sie bereits eine ältere Version von PublicanCreators installiert haben, können SIe ein vollständiges <command>rake setup_start</command> starten, oder Sie kürzen es durch die nächsten Schritte ab: PublicanCreators installieren Ruby installieren Einführung Es überprüft, auf welcher Linuxversion es läuft. Dann reagiert es darauf, indem es auf verschiedene Weise die Hard-Dependencies (Linux-Pakete wie yad) installiert. Bedenken Sie, das die 2.2.1 aus ruby-2.2.1 mit Ihrer Ruby-Version übereinstimmen muss. Geben Sie jetzt ein: <command>rvm install <replaceable>2.2.1</replaceable> </command>. Falls mittlerweile ein neueres Ruby als 2.2.1 veröffentlicht wurde, geben Sie diese Version ein. Einer der einfachsten Wege Ruby zu installieren ist mit RVM. Dazu folgen Sie den nächsten Schritten: PublicanCreators benötigt eine 4.x Version von Publican, da es Parameter wie <quote>--dtdver</quote> benutzt. Falls Sie Ubuntu benutzen, fügt das Setup Programm ein Launchpad PPA hinzu, welches rückportierte Versionen der 4.x Publican Version für Trusty (14.04) und Utopic (14.10) beinhaltet. Vivid Velvet liefert bereits eine passende Version aus. Das Setup Die Installation kann (wie die Ruby-Installation) etwas dauern, da manche der Abhängigkeiten nativ auf Ihrem Computer kompiliert werden müssen. Als letzten Schritt legt das Setup_Programm zwei *.desktop Dateien für PublicanCreators und RevisionCreator in <filename>.local/share/applications</filename> an. Daher können Sie beides durch den normalen Programmstarter ausführen. Der Output sollte in etwa so aussehen: Der Output sollte in etwa so aussehen: Das Setup erledigt die folgenden Dinge: Der Output sollte in etwa so aussehen: Um RVM zu nutzen haben Sie jetzt 2 Optionen. Entweder loggen Sie sich aus, und wieder ein. Oder aber Sie tippen in die Konsole <command>source /home/<replaceable>sascha</replaceable>/.rvm/scripts/rvm</command>. Statt <quote>sascha</quote> geben Sie Ihren Usernamen ein. Geben Sie folgendes in der Konsole ein: <command>gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 </command> Tippen Sie jetzt: <command>curl -sSL https://get.rvm.io | bash -s stable </command> Aktualisierung von einer früheren Version Jetzt haben Sie (hoffentlich) ohne Probleme Ruby installiert. Für weitere Informationen zu RVM besuchen Sie <link xlink:href="https://rvm.io/">link</link>. 