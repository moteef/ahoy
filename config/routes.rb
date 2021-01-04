# For frexit we need to temporarly serve Ahoy from '/ahoy/*' (legacy) and from
# '/api/v1/ahoy'. When frexit is done only '/api/v1/ahoy' should be served.

Rails.application.routes.draw do
  mount Ahoy::Engine => "/" if Ahoy.api
end

Ahoy::Engine.routes.draw do
  scope path: 'ahoy', module: 'ahoy' do
    resources :visits, only: [:create]
    resources :events, only: [:create]
  end

  scope path: 'api/v1/ahoy', module: 'ahoy' do
    resources :visits, only: [:create]
    resources :events, only: [:create]
  end
end
