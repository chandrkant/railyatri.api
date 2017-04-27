#Train releated info like time table ,live status ,seat availability , pnr status
class Api::TrainController < ApplicationController
	#GET /api/time_table
	def time_table
		url = API_URLS['time_table']+"#{params[:train_number]}.json?stop=true"
		req = RestClient.get(url)
		json_response(req)
	end

  #GET /api/live_arr_dep
	def live_arr_dep
		url = API_URLS['live_arr_dep']
		if params[:to_code].present?
			url = url+"#{params[:from_code]}/#{params[:to_code]}/8.json"
		else
			url = url+"#{params[:from_code]}/8.json"
		end	
		req = RestClient.get(url)
		json_response(req)
	end

  #GET /api/train_bw_station
	def train_bw_station
		url = API_URLS['train_bw_station']
		url = url+"?from=#{params[:from_code]}&to=#{params[:to_code]}"	
		req = RestClient.get(url)
		json_response(req)
	end

  #GET /api/train_bw_station
	def pnr_status
		
	end

  #GET /api/live_train_status
	def live_train_status
		
	end

  #GET /api/seat_availability
  def seat_availability
  	
  end

end
