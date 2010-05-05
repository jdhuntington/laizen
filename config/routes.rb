ActionController::Routing::Routes.draw do |map|
  Clearance::Routes.draw(map)
  map.resources :repositories do |repositories|
    repositories.resources :commits do |commits|
      commits.resources :comments
    end
  end
  map.resource :dashboard
  map.root :controller => "dashboards"
end
