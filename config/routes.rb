Rails.application.routes.draw do
  devise_for :recruiters
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :home, path: "" do
    get :helloworld
    post :check_admin_token
  end

  resources :users do
    collection do
      post :sign_up
      post :sign_in_by_code
      post :send_verification_code
      get :recommend_token
      get :recommend_records
    end
  end

  resources :profiles do
    collection do
      get :detail
      post :upload_avatar
      post :upload_attachment
      post :update_english_skills
      post :update_basic
      post :update_availability
      post :update_technical_skills
      post :update_experience
      post :update_projects
      post :update_web_three
      post :update_salary
    end
  end

  resources :interview_reports, only: [:create, :show]

  resources :upload_files, only: [:create]

  resources :recruiter_forms, only: [:create]

  resources :recruiters do
    collection do
      post :sign_up
      post :sign_in_by_code
      post :send_verification_code
    end
  end
end
