# frozen_string_literal: true

Rails.application.routes.draw do
  root 'github_users#search'
  get 'search' => 'github_users#search'
  post 'show' => 'github_users#show'
end
