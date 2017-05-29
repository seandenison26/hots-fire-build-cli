class Build
	attr_accessor :name, :votes, :link, :lvls
	attr_reader :hero

	def initialize(build_hash)
		super
	end 

	def hero=(hero)
		@hero = hero
		hero.builds << self unless hero.builds.include?(self)
	end
end
