require 'parseconfig'
require 'dir'

module PublicanCreatorsGet

  # ask for the title
  def self.title
    # Put the yad input as variable titlein
    titlein = `yad --title="Create documentation" --center --on-top --form --item-separator=, --separator=" "  --field="Environment:CBE" --field="Type:CBE" --field="Optional:CBE" --field="Enter a title name (with underscores instead of blanks and without umlauts):TEXT" --button="Go!" "Work,Private" "Article,Book" "Normal,Report,Homework"`
    # Format: Work/Privat!Article/Buch!title!Normal/Report/Homework
    # Cleanup the array
    titlechomp = titlein.chomp
    # Split the variable to the array title[*]
    title = titlechomp.split(' ')
  end

  # get configuration
  def self.config
    #config = ParseConfig.new(File.join(File.dirname(__FILE__), '.publicancreators.cfg'))
    home = Dir.home
    config = ParseConfig.new("#{home}/.publicancreators.cfg")
    name = config['name']
    email_private = config['email_private']
    language = config['language']
    use_brand = config['use_brand']
    title_logo = config['title_logo']
    legal = config['legal']
    brand = config['brand']
    company_name = config['company_name']
    company_division = config['company_division']
    email_business = config['email_business']
    brand_dir = config['brand_dir']
    globalentities = config['globalentities']
    articles_dir = config['articles_dir']
    reports_dir = config['reports_dir']
    books_dir = config['books_dir']
    articles_dir_priv = config['articles_dir_priv']
    homework_dir = config['homework_dir']
    books_dir_priv = config['books_dir_priv']
    brand_private = config['brand_private']
    brand_homework = config['brand_homework']
    db5 = config['db5']
    [name, email_private, language, use_brand, title_logo, legal, brand, company_name, company_division, email_business, brand_dir, globalentities, articles_dir, reports_dir, books_dir, articles_dir_priv, homework_dir, books_dir_priv, brand_private, brand_homework, db5]
  end
end