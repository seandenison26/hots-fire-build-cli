class Build
	include Concerns::InstanceMethods
	attr_accessor :name, :votes, :link, :lvls
	attr_reader :hero
	
	@@all = [] 

	def initialize(build_hash)
		super
	end 

	def hero=(hero)
		@hero = hero
		hero.builds << self unless hero.builds.include?(self)
	end

	def self.create(hash)
		build = Build.new(hash)
		build.save
		build
	end

	def self.create_builds_from_hero(hero)
		links = Scraper.get_build_links(hero.name)
		links.each { |link|
			build = Build.create(Scraper.get_build_data_from_link(link))
			build.hero = hero
			build
		}
	
	end
end
