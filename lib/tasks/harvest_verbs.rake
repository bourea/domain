namespace :harvest do
  desc "Download most common verbs"
  task :top_verbs => :environment do
    process("lookup_acme_most_common", "most common verbs")
  end

  desc "Download regular verbs"
  task :regular_verbs => :environment do
    process("lookup_englishclub_regular", "regular verbs")
  end

  desc "Download grammar verbs"
  task :grammar_verbs => :environment do
    process("lookup_grammar", "grammar verbs")
  end

  desc "Download proper names"
  task :proper_names => :environment do
    process("lookup_proper_name", "proper names")
  end

  def process(method, log)
    verbs = Verb.send(method)
    w = Whois::Client.new
    verbs.each do |verb|
      name = clean(verb) 
      
      extension = [".me", ".com"]
      extension.each do |e|
        info = whois(w, name + e)
        save_domain(name + e, info, log)
      end
    end
  end

  def save_domain(name, info, source)
    @attr = {
      :name => name,
      :source => source,
      :available => info.available?,
      :registered => info.registered?,
      :registrar => registrar(info),
      :created_on => info.created_on,
      :updated_on => info.updated_on,
      :expires_on => info.expires_on
    }
    existing_domain = DomainName.find_by_name(name)
    if existing_domain.blank?
      puts "creating #{name}"
      DomainName.create!(@attr)
    else
      puts "updating #{name}"
      DomainName.update(existing_domain.id, @attr)
    end
  end

  def whois(whois, name)
    whois.query(name)
  end

  def registrar(info)
    info.registrar.blank? ? "none" : info.registrar.name
  end
  
  def clean(string)
    string = string.downcase            # lowercase
    string = string.gsub(/\s+/, "")     # remove whitespace
    string = string.scan(/[a-z]+/).to_s # only keep alpha haracters
  end


  # find invalid domains
  # domains = DomainName.where("name like '%)%'")
  # find availabe domains
  # domains = DomainName.where(:available => true)
end

