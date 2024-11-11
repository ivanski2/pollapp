module Admin
  class AdminSessionsController < ApplicationController
    def new
    end

    def create
      administrator = Administrator.find_by(username: params[:username])
      if administrator && administrator.authenticate(params[:password])
        session[:admin_id] = administrator.id
        redirect_to admin_polls_path, notice: "Successfully logged in!"
      else
        flash.now[:alert] = "Invalid username or password"
        render :new
      end
    end

    def destroy
      session[:admin_id] = nil
      redirect_to root_path, notice: 'Logged out!'
    end
  end
end
