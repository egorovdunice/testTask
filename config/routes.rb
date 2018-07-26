# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'statics#home'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :tasks
end
