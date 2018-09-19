Rails.application.routes.draw do
#	rails migration EnableUuidExtension
#    	rails generate model manufacturer name:string description:string location:string
#	rails generate model material style:string group:string manufacturer:references:uuid name:string flexibel:boolean ipc_sm_840_class:string ipc_slash_sheet:string tg_minimum:integer td_minimum:integer  additional:string link:url remark:text
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :materials,  only: [:index, :show]
  resources :manufacturers, only: [:index, :show]
  resources :functions,  only: [:index, :show]
  resources :groups,  only: [:index, :show]
  # To capture routing error and display error message without trace
  match '*path', :to => 'application#routing_error', via: [:get]  
  match '*path', :to => 'application#posting_error', via: [:post, :put, :patch, :delete]  

end
