Rails.application.routes.draw do

  root to: 'visitors#index'
  match "/simulator", :controller => "visitors", :action => "simulator", via:[:get,:post]
  match "/ladders", :controller => "visitors", :action => "ladders", via:[:get]  
  match "/scoreboard", :controller => "visitors", :action => "scoreboard", via:[:get]  

  match "/reports", :controller => "reports", :action => "reports", via:[:get]  

  devise_for :users
  resources :users
  post 'savenew', to: 'users#savenew' #work around so devise doesn't grab my new User attempts
  
  #delete 'reset_system', to: 'users#reset_system' #work around so devise doesn't grab my new User attempts
  match "/reset_system", :controller => "users", :action => "reset_system", via:[:delete]  

  resources :players  
  resources :matches  


  resources :orgs do     
  	resources :leagues do
  		member do
  			match :assign, via:[:get,:post,:delete]
  		end
  	end
  end
end
