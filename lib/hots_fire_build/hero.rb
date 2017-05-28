class Hero
	attr_accessor :name, :title, :role, :franchise, :builds, :abilities

	@@all = []

	def initialize(hero_hash) 
		hero_hash.each { |k,v|
			self.send("#{k}=", v)
		}	
		@builds = []
		@abilities = []
		save
	end

	def get_builds
		[]
	end

	def get_abilities
		[]
	end

	def save
		@@all << self
	end

	def self.find_or_create_by_name(name)
			
	end
	
end
