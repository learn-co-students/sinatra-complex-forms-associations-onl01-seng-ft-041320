class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    #binding.pry
    if !params[:pet][:owner_id].nil?
      @pet.owner = Owner.find_by(id: params[:pet][:owner_id])
    elsif !params[:owner][:name].nil?
      @pet.owner = Owner.create(name: params[:owner][:name])
    end
    #binding.pry
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by(id: params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 

    ####### bug fix
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end
    #######

    @pet = Pet.find_by(id: params[:id])
    @pet.update(params[:pet])
    #binding.pry
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
    elsif !params[:pet][:owner_id].empty?
      @pet.owner = Owner.find_by(id: params[:pet][:owner_id])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end