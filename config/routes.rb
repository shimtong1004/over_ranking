Rails.application.routes.draw do
  
  # get   '/login', :to => 'sessions#new', :as => :login
  # match '/auth/:provider/callback', :to => 'sessions#create', via: [:get, :post]
  # match '/auth/failure', :to => 'sessions#failure', via: [:get, :post]
#   
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/failure'
  # get '/logout', :to => 'sessions#destroy'
  
  # match '/auth/:provider/callback', :to => 'sessions#create', via: [:get]
  
  get '/auth/:name/callback', :to => 'sessions#create'
  
  # get '/auth/:name/callback', :to => 'sessions#create' do
    # auth = request.env["omniauth.auth"]
    # session[:user_id] = auth["uid"]
    # session[:user_info] = auth["info"]
    # session[:debug] = auth.to_yaml
    # redirect OmniAuth.config.full_host
  # end
  
  get '/auth/failure', :to => 'sessions#failure' do
    erb "<h1>Authentication Failed:</h1><h3>message:#{params[:message]}<h3> <pre>#{params}</pre>"
  end
  
  
  get '/auth/:provider/deauthorized', :to => 'sessions#deauthorized' do
    erb "#{params[:provider]} has deauthorized this app."
  end
  
  get '/logout', :to => 'sessions#destroy', :as => :logout do
    session[:user_id] = nil
    session[:user_info] = nil
    redirect OmniAuth.config.full_host
  end

  resources :over_tags do
    member do
      get 'detail'
    end
  end
  resources :over_heros
  resources :over_heros do
    collection do
      # get 'get_heroes'
      # get 'get_hero'
      # get 'get_allHeroes'
    end
  end
  
  resources :over_platforms do
    collection do
      # get 'get_platforms'
    end
  end
  
  resources :over_achievements do
    collection do
      # get 'get_achievement'
    end
  end
  
  resources :over_profiles do
    collection do
      # get 'get_profile'
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'over_tags#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
