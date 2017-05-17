class Api::EcommController < ApplicationController

	def save_order
		url = "https://food1.railyatri.in/ecomm/save_order.json"
		req = RestClint.post(url)
	end

	def block_tickte

	end
	def bus_search
		begin
			qury = "?source="+params[:from_code]+"&destination="+params[:to_code]+"&doj="+params[:doj]+"&num_of_pass="+params[:num_of_pass]
			url=  API_URLS['get_available_bus_trips']+qury
			puts "#{url}"
			new_hash = params
			from_name = params[:from_name].split('-to-')[0].titleize
			to_name = params[:from_name].split('-to-')[1].titleize
			city = {from_name: from_name,to_name: to_name}
			params = new_hash.merge(city)
			req = RestClient.get(url)
			logger.info(req)
			req = params.merge(JSON.parse(req.body))
		rescue Exception=> e
			req= {success: false,message: e.message}
		end
		json_response(req.to_json)
	end
end
