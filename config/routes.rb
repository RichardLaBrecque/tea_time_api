Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :customers do
        resources :subscriptions
        #ask WHY NOT DO THE THING
        put '/subscriptions', to: 'subscriptions#update'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
