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
    #binding.pry
    @pet = Pet.create(params[:pet])
    
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @pet.owner = @owner
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    #binding.pry
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])

    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end




  #patch '/owners/:id' do 
#
  #  if !params[:owner].keys.include?("pet_ids")
  #    params[:owner]["pet_ids"] = []
  #  end
#
#
  #  @owner = Owner.find(params[:id])
  #  @owner.update(params[:owner])
#
  #  if !params["pet"]["name"].empty?
  #    @owner.pets << Pet.create(name: params["pet"]["name"])
  #  end
#
  #  redirect "owners/#{owner.id}"
  #
  #end
end