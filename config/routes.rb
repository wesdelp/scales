Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/build', to: 'scales#build'
  root to: 'scales#show'
end
