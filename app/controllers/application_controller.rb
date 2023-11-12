class ApplicationController < ActionController::Base
    include Pundit::Authorization

    before_action :set_current_user
    before_action :require_user_logged_in!

    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    def require_user_logged_in!
        redirect_to sign_in_path, alert: "You must be signed in to do that." if Current.user.nil?
    end

    def current_user
        Current.user
    end
end
