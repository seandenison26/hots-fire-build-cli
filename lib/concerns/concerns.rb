module Concerns
	
	module InstanceMethods
			#Initializes Class from a hash using mass assignment
		def initialize(hash)
			hash.each { |k,v|
				self.send("#{k}=", v)
			}
		end	
			#Persists the object instance in the class's all variable 	
		def save
			self.class.all << self
		end

	end

	module ClassMethods
	end

end
