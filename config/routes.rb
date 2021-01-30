Rails.application.routes.draw do
  root 'ip_addresses#index'
  post 'ip_addresses/validate', to: 'ip_addresses#validate', as: 'validate'
end
