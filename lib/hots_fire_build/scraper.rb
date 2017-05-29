class Scraper
		#Returns a list of the current free heroes.
	def self.get_free_hero_list
		home = Nokogiri::HTML(open("http://www.heroesfire.com/"))
		list = home.css("div.free span.link-wrap a").map {|link| link.attr("href").gsub("/hots/wiki/heroes/", "").capitalize}
	end
		#Returns hero hash based on a given name
	def self.get_hero_data(name)
		begin
			home = Nokogiri::HTML(open("http://www.heroesfire.com/hots/wiki/heroes/#{name.downcase}"))
		rescue	
			raise NoHeroName
		else	
			arr = home.css(".hero-stats").text.gsub("\t","").split(/\n+/)
			data = {
				:name => name,
				:title => arr[1].split("Title: ")[1],
				:role	=> arr[2].split("Role: ")[1],
				:franchise => arr[3].split("Franchise: ")[1],
			}
		end	
	end
		#Returns an array of build hashes based on a given name
	def self.get_build_links(name)
		home = Nokogiri::HTML(open("http://www.heroesfire.com/hots/wiki/heroes/#{name}/guides"))
		links = home.css("div.browse-item-list.browse-table a").find_all{|link| link.attr("style") != "display:none"}
	end
	
	
	def self.get_build_data_from_link(link)
		home = Nokogiri::HTML(open("http://www.heroesfire.com#{link}"))
		binding.pry

	end
		#Returns an abilities hash based on a given name
	def self.get_abilities_data
		home = Nokogiri::HTML(open("http://www.heroesfire.com/hots/wiki/heroes/#{name}"))
	end
end

class NoHeroName < StandardError
	
end
