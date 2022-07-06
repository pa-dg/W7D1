class ApplicationController < ActionController::Base
    # skip_before_action :verify_authenticity_token
    # protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?

    # def login(user)
	#     session[:session_token] = user.session_token
    # end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    #if they are not logged in redirect them to login form

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def require_logged_out
        redirect_to cats_url if logged_in?
    end

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout_user!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def logout!
        current_user.reset_session_token! if self.logged_in?
        session[:session_token] = nil
        @current_user = nil
    end


end
