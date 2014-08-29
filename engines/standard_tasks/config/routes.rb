StandardTasks::Engine.routes.draw do
  resources :funders, only: [:create, :update, :destroy]
  resources :whiteboard_images, only: [:create, :update]
end
