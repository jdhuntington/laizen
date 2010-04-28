ActionController::Routing::Routes.draw do |map|
  map.resources :repositories do |repositories|
    repositories.resources :commits
  end

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end
  # map.root :controller => "welcome"
end
