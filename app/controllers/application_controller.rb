class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/recipes' do
    #binding.pry
    @recipes = Recipe.all
    erb :recipes
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    #binding.pry
    @recipe = Recipe.find{|r| r.id == params[:id].to_i}
    erb :show
  end

  delete '/recipes/:id/delete' do
    Recipe.delete(params[:id].to_i)
  end

  get '/recipes/:id/edit' do
    #binding.pry
    @recipe = Recipe.find{|r| r.id == params[:id].to_i}
    erb :edit
  end

  patch '/recipes/:id/edit' do
    #binding.pry
    id = params[:id].to_i
    name = params[:name]
    ingredients = params[:ingredients]
    cook_time = params[:cook_time]
    Recipe.update(id, name: name, ingredients: ingredients, cook_time: cook_time)
    redirect "/recipes/#{id}"
  end

  post '/recipes' do
    #binding.pry
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe[:id]}"
  end

end
