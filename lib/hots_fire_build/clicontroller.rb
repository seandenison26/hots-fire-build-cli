class HotsFireBuild::CLI
		#Begins the application loop.
	def call
		welcome
		view = gets.chomp
		while view != "exit" do
			case view
				when Hero
					hero = view.dup.freeze
					puts hero_data(view)
					puts build_list(view)
					puts "Enter the number of a build to see that build or type \"hero search\" to search for a new hero"
					view = gets.chomp
					if view.to_i > 0 && view.to_i <= hero.builds.size
						view = hero.builds[view.to_i - 1]
					end	
				when Build
					puts build_levels(view)
					puts "If you would like to go back and see other hero buils type \"go back\". To search another hero type \"hero search\"."
					view = gets.chomp
				when "free"
					puts free_list
					view = "hero search"		
				when "hero search"
					puts "What Hero would you like to see?"
					view = gets.chomp
				when String
					view = Hero.find_or_create_by_name(view)
				else
					puts "I'm sorry, that made no sense to me."
					view = gets.chomp
			end	
		end
	end
	
		#Puts out a welcome message to the user, explaining initial commans, initializes view variable with user input. 
	def welcome
		puts "Welcome to Hots-Fire-Builder, powered by www.heroesfire.com!" 
		puts "What would you like to do? Find a Hero by name or see a list of all Heroes?"
		puts "Type \"exit\" at any point to exit the application."
		puts "Enter \"free\" to see a list of free heroes or the name of the Hero you wish to search for:"
	end

		#Returns a list of the current free to play heroes.
	def free_list
	        heroes = Scraper.get_free_hero_list
		list = "The current free heroes are:\n#{heroes.join("\n")}"
	end

		#Returns a formatted string of the heroes data.
	def hero_data(hero)
		name = hero.name.capitalize
		hereStr = 	"\n#{name}, the #{hero.title}\n" +
				"Role: #{hero.role}\n" +
				"Franchise: #{hero.franchise}\n"
	end
	
		#Returns a formatted list of the hero's top rated builds.
	def build_list(hero)
		#This Line is just to limit the initial amount of builds shown. Possibly implement a way to search further.
		builds = hero.builds
		if builds.size >= 5
			builds = builds.slice(0,5)
		end
		list = builds.map{|build| "#{hero.builds.index(build) + 1}. #{build.name} #{build.votes}"}.join("\n")
	end

		#Returns a formatted list of the build's levels.
	def build_levels(build)
		levels = "#{build.name}\n" + build.lvls.reduce("") {|str,(k,v)| str + "#{k.to_s}: #{v}\n"} 
	end 	
end


