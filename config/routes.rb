ActionController::Routing::Routes.draw do |map|
  map.jasmine "/jasmine", :controller => :jasmine, :action => 'run'
end
