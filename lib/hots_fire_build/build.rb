class Build
	include Concerns::InstanceMethods
	extend Concerns::ClassMethods
	attr_accessor :name, :votes, :link, :lvls
	attr_reader :hero
	
	@@all = [] 
	
		#Returns the array containing all instances of the Build class
	def self.all
		@@all
	end
	
		#Initializes a new Build object with mass assignment
	def initialize(build_hash)
		super
	end 
		#Assigns a hero object to @hero and ands the build to the heroes builds unless it is already there,
	def hero=(hero)
		@hero = hero
		hero.builds << self unless hero.builds.include?(self)
	end
		#Creates an instance of the Build object and saves it
	def self.create(hash)
		Build.new(hash).tap { |build|
			build.save
		}
	end
		
	def self.create_builds_from_hero(hero)
		links = Scraper.get_build_links(hero.name)
		links.each { |link|
			Build.create(Scraper.get_build_data_from_link(link)).tap { |build| 
				build.hero = hero
			}
		}
	end
end
