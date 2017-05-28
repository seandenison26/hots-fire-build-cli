class HotsFireBuild::CLIController
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
						view = hero.builds[view - 1]
					elsif view != String
						view = hero
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
					view = Hero.find_or_create_hero(view)
					if view.is_a?(Error)
						puts Error.message
						view = "hero search"
					end	
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

	def free_list
		#heroes = Scraper.get_free_hero_list
		heroes = ["D.Va", "Lucio", "Varian", "Naazeebo"]
		list = heroes.join("\n")
	end

	def hero_data(hero)
		#returns hero data string
	end

	def build_list(hero)
		builds = hero.builds.map{|build| "#{hero.builds.index(build) + 1}. #{build}"}.join("\n")
	end

	def build_levels(build)
		build.get_levels	
		levels = "#{build.name}\n" + build.levels.reduce("") {|str,(k,v)| str + "#{k.to_s}: {v}\n"} 
	end 	
end


