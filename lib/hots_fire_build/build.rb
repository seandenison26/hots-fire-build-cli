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
end
