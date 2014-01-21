Tryblog2::Application.routes.draw do
  resources :posts, only: [:index, :create, :update]
  root :to => 'posts#index'
end
