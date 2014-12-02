Slacker::Engine.routes.draw do
  resources :slack_messages, only: [:create, :show]
end
