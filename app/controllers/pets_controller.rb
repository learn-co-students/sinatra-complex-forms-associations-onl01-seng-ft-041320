class PetsController < ApplicationController

#index
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

#new
  get '/pets/new' do
    erb :'/pets/new'
  end

#create
  post '/pets' do
    @pet = Pet.create(params[:pet])

    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  #Edit
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

#show
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

#update
  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])


    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
