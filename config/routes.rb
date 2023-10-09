Rails.application.routes.draw do
  
  post '/job_openings' => 'job_openings#create'

  resources :contacts, only: [:create]

end
