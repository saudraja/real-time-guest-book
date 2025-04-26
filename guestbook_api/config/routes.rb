Rails.application.routes.draw do
  # Public Comments API
  get  '/comments', to: 'guestbook_entries#index'
  post '/comments', to: 'guestbook_entries#create'

  # Admin Comments API
  namespace :admin do
    post '/login', to: 'sessions#create'
    get    '/comments',          to: 'guestbook_entries#index'
    patch  '/comments/:id/mark_spam', to: 'guestbook_entries#mark_spam'
    delete '/comments/:id',      to: 'guestbook_entries#destroy'
  end

  mount ActionCable.server => '/cable'
end
