Blog::Application.routes.draw do
  root to: 'articles#index'
  resources :articles do
    get 'search', :on => :collection
  end
  resources :comments
end
