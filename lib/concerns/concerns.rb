module Concerns
	
	module InstanceMethods
			#Initializes Class from a hash using mass assignment
		def initialize(hash)
			hash.each { |k,v|
				self.send("#{k}=", v)
			}
		end	
	
		def save
			@@all << self
		end

	end

	module ClassMethods

	end

end
