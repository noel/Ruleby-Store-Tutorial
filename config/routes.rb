ActionController::Routing::Routes.draw do |map|
  
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.resources :user_sessions

  map.resources :users

  map.resource :cart
  map.checkout "checkout", :controller => "carts", :action => "checkout"
  map.update "update", :controller => "carts", :action => "update", :method => "post"


  map.resources :products
  map.resources :categories
  map.root :products
  map.connect ':controller/:action/:id' 
end
