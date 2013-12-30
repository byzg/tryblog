Tryblog2::Application.routes.draw do
  resources :posts, only: [:index, :create, :destroy]
  root :to => 'posts#index'
end
