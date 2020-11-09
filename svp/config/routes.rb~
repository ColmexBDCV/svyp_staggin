Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admins, controllers: { registrations: "registrations"}
  devise_scope :admin do
    get "/acceder" => "devise/sessions#new"
  end

  get 'panel/panel' => 'panel#panel', :as => :panel
  get 'panel/principal' => 'panel#principal', :as => :panel_princ
  get 'panel/index' => 'panel#index', :as => :panel_index
  post 'panel/index' => 'panel#index', :as => :panel_index_post
  get 'panel/generar' => 'panel#generar', :as => :panel_nuevo
  get 'panel/editar' => 'panel#editar', :as => :panel_editar
  post 'panel' => 'panel#crear'
  get 'panel/:id' => 'panel#mostrar', :as => :panel_mostrar
  delete 'panel/:id' => 'panel#eliminar', :as => :panel_eliminar
  put 'panel/editar' => 'panel#actualizar'
  patch 'panel/editar' => 'panel#actualizar'

  get '/' => 'principal#inicio', :as => :inicio
  get '/acerca-de' => 'principal#acerca', :as => :acerca
  get '/colaboradores' => 'principal#colaboradores', :as => :colaboradores
  get '/seminarios' => 'principal#seminarios', :as => :seminarios
  get '/seminario/:sem' => 'principal#seminario', :as => :seminario
  get '/publicaciones' => 'principal#publicaciones', :as => :publicaciones
  get '/publicacion/:pub' => 'principal#publicacion', :as => :publicacion
  get '/multimedia' => 'principal#multimedia', :as => :multimedia

  root to: 'principal#inicio'
end
