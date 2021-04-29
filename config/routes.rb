Rails.application.routes.draw do

  root to: "home#index"		# Available of all jobs to non-logged users
  get 'authentication/login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  post "login", to: "authentication#login"
  resources :applyjobs, only: [:create, :index]
  get "admin_login", to: "admins#generate_otp"
  post "admin_login", to: "admins#verify_otp"

  get "admin/jobs", to: "jobs#available_job"	# Available jobs
  post "admin/create_jobs", to: "jobs#create_job" # create jobs
  patch "admin/update_jobs", to: "jobs#edit_job" #update job status
  patch "admin/update_user", to: "jobs#update_user_status"  #admin update user status
  post "apply", to: "applyjobs#create"		# to apply for jobs
end
