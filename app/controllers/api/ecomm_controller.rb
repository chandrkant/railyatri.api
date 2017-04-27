class Api::EcommController < ApplicationController
	
	def save_order
		url = "https://food1.railyatri.in/ecomm/save_order.json"
		req = RestClint.post(url)
	end

	def block_tickte
		
	end
end
