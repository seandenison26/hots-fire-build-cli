module Concerns
	
	module InstanceMethods
		def initialize(hash)
			hash.each { |k,v|
				self.send("#{k}=", v)
			}
		end	

	end

	module ClassMethods

	end

end
