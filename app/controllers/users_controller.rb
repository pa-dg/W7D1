class UsersController < ApplicationController
    #to allow signup --> we provide new/create actions
    # before_action :require_logged_out, only: [:new, :create, :edit, :update]
    before_action :require_logged_in
    #before_action --> this callback to redirect user to the cat's index page if the user tries to visit the login/signup pages when they've already signed in

    def new
        @user = User.new
        render :new
    end

    def create
	    @user = User.new(user_params)
        
        if @user.save
            login_user!(@user)
            redirect_to cats_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    private

    def user_params
        self.params.require(:user).permit(:password, :username)
    end
    
end
