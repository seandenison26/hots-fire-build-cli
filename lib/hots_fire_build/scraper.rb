class Scraper
		#Returns a list of the current free heroes.
	def self.get_free_hero_list
		home = Nokogiri::HTML(open("http://www.heroesfire.com/"))
		list = home.css("div.free span.link-wrap a").map {|link| link.attr("href").gsub("/hots/wiki/heroes/", "").capitalize}
	end
end
