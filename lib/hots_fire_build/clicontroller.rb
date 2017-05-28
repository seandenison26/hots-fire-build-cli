class HotsFireBuild::CLIController
	def call
		puts "Welcome to Hots-Fire-Builder, powered by www.heroesfire.com!" 
		puts "What would you like to do? Find a Hero by name or see a list of all Heroes?"
		puts "Enter \"free\" or the name of the Hero:"
		input = gets.chomp
		while input != "exit" do
			if input == "free"
				puts free_list 
				"What Hero would you like to see?"
			end
			input = gets.chomp
		end


		
	end

	def free_list
		#heroes = Scraper.get_free_hero_list
		puts "Hey I was called!"
		heroes = ["D.Va", "Lucio", "Varian", "Naazeebo"]
		list = heroes.join("\n")
	end

	def hero_data(name)

	end

	def build_data(build_num)

	end 	
end


