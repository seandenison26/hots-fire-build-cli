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
		#Returns an array of build links based on a given name
	def self.get_build_links(name)
		home = Nokogiri::HTML(open("http://www.heroesfire.com/hots/wiki/heroes/#{name}/guides"))
		links = home.css("div.browse-item-list.browse-table a").find_all{|link| link.attr("style") != "display:none"}.map{|link| link.attr("href")}
	end
	
		#Returns a build data hash from a given link	
	def self.get_build_data_from_link(link)
		home = Nokogiri::HTML(open("http://www.heroesfire.com#{link}"))
		#Dev note: This array currently return the skills names of a particular builds variants. Good to know if we wish to add that functionality.
		levels = home.css("div.skills img") .map{|link| link.attr("src").slice(/[\w-]+.png/).split(".png")[0].gsub("talent","").split("-").map(&:capitalize).join(" ")}
		lvls = levels.slice(0,7)
		data = {
			:name => home.css("div.desc h2").first.text,
			:link => link,
			:votes => home.css("div.rank").first.text,
			:lvls => {
				:Level1 => lvls[0],
				:Level4 => lvls[1],
				:Level7 => lvls[2],
				:Level10 => lvls[3],
				:Level13 => lvls[4],
				:Level16 => lvls[5],
				:Level20 => lvls[6]
			}	
		}
	end
		#Returns an abilities hash based on a given name
	def self.get_abilities_data
		home = Nokogiri::HTML(open("http://www.heroesfire.com/hots/wiki/heroes/#{name}"))
	end
end

class NoHeroName < StandardError
	
end
