class Hero
	include Concerns::InstanceMethods
	attr_accessor :name, :title, :role, :franchise, :builds, :abilities

	@@all = []

		#initializes a hero with a hero hash and build and abilities arrays
	def initialize(hero_hash) 
		super
		@builds = []
		@abilities = []
	end
	
		#Creates a new hero from the Scraper object
	def self.create_from_name_scrape(name)
		begin
			hero = Hero.new(Scraper.get_hero_data(name))
		rescue
			raise NoHeroName
		else
			hero.save
			hero	
		end
	end

		#Persists the hero in @@all
	def save
		@@all << self
	end
	
	def add_build(build)
		@builds << build
		build.hero = self unless build.hero == self
	end

		#Searches the all array for a Hero by a given name
	def self.find_by_name(name)
		@@all.find {|hero| hero.name == name}
	end

		#Searches the all array for the hero by name, if no hero is found returns a new hero 
	def self.find_or_create_by_name(name)
		search = Hero.find_by_name(name) 
		if search != nil
			return search
		else	
			begin
				hero = Hero.create_from_name_scrape(name)
			rescue	
				puts "No Hero was found by that name. Please recheck your spelling or formatting."
				return "hero search"
			else
				Build.create_builds_from_hero(hero)
				hero
			end		
		end

	end
	
end

	
