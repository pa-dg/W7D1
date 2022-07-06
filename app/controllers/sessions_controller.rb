class SessionsController < ApplicationController
    #this is the session for the user only when logged in
    before_action :require_logged_in, only: [:new, :create]

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

        if @user
		    login(@user)
		    redirect_to cats_url
	    else
            flash.now[:error] = "Wrong username/password" #=> we want to render now at the current request
		    render :new
        end
    end

    def destroy
        logout_user!
        flash[:success] = "You've been logged out successfully"
	    redirect_to cats_url
    end

end
