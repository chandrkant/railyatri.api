Rails.application.routes.draw do
  devise_for :users
  namespace :api do
  	get "/time_table/:train_number"=>"train#time_table"
  	get "/live_arr_dep/:from_code"=>"train#live_arr_dep"
    get "/live_arr_dep/:from_code/:to_code"=>"train#live_arr_dep"
  	get "/train_bw_station/:from_code/:to_code"=>"train#train_bw_station"
    get "/train_bw_station/:from_code"=>"train#train_bw_station"
  	post "/pnr_status"=>"train#pnr_status"
  	get "/live_train_status"=>"train#live_train_status"
  	get "/seat_availability"=>"train#seat_availability"
    post "/instant_platform_update"=>"train#instant_platform_update"
    get "/bus/get_available_bus_trips"=>"ecomm#bus_search"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
