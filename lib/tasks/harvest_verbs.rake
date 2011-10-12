namespace :harvest do
  desc "Download verbs"
  task :top_verbs => :environment do
    verbs = Verb.lookup
    w = Whois::Client.new
    verbs.each do |verb|
      domain = w.query("#{verb}.me")
			if domain.available? 
			  puts "#{verb}.me is available"
      else
        puts "*"
			end
    end
  end
end

