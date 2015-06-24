Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: "devise/registrations#new"
  end

  get 'autocomplete', to: 'medicine#autocomplete'
  get 'cabinet', to: 'medicine#cabinet'
  post 'add_to_cabinet', to: 'medicine#add_to_cabinet'
  delete 'destroy/:id', to: 'medicine#destroy', as: 'destroy_medicine'
  post 'interactions', to: 'medicine#query_for_all_interactions'
  post 'session_clear', to: 'session#session_clear'
end
