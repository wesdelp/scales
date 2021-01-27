Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/build', to: 'scales#build'
  get '/generate_midi', to: 'scales#generate_midi'
  root to: 'scales#show'
end
