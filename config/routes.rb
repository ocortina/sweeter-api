Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  get '/sweets', to: 'sweets#index'

  get '/:username/sweets', to: 'sweets#show_all_sweets'  # Muestra todos los sweets
  post '/:username/sweets', to: 'sweets#create_sweet'
  get '/:username/sweets/:sweet_id', to: 'sweets#show_sweet'
  put '/:username/sweets/:sweet_id', to: 'sweets#update_sweet'
  delete '/:username/sweets/:sweet_id', to: 'sweets#destroy_sweet'

  post '/:username/sweets/:sweet_id/favorite', to: 'favorites#favorite_sweet'
  delete '/:username/sweets/favorites/:sweet_id', to: 'favorites#destroy_favorite_sweet'
  get '/:username/favorites', to: 'favorites#show_all_favorite_sweets'

  post '/:username/following/:following_id', to: 'relations#start_following'
  delete '/:username/following/:following_id', to: 'relations#destroy_following'
  get '/:username/followings', to: 'relations#show_all_followings'
  get '/:username/followers', to: 'relations#show_all_followers'

end
