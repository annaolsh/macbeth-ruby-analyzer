Rails.application.routes.draw do
  get '/' , to: 'plays#index'
  post '/plays', to: 'plays#create'
  get '/plays/:id', to: 'plays#show', as: 'play'
end
