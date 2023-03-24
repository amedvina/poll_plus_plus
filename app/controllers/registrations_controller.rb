class RegistrationsController < ApplicationController
	skip_before_action :require_user_logged_in!
	
	def new
		if Rails.env.production?
			render plain: "Not found", status: :not_found and return
		end
		@user = User.new
	end

	def create
		if Rails.env.production?
			render plain: "Not found", status: :not_found and return
		end
		
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path, notice: "Successfully created account"
		else
			render :new
		end
	end
	
	private

	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation)
	end
end    