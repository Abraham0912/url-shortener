class PostsController < ApplicationController
    before_action :authenticate_user!
  
    def show
      render json: { message: "Tines acceso al controller posts" }
    end
end