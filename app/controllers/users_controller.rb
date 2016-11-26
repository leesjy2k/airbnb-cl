class UsersController < ApplicationController
	before_action :find_user, only: [:show, :edit, :update, :destroy]

	def show
	end

	def edit
	end

	def create
		if match_password
	    @user = User.new(permit_params)
	    # @user.avatar = "default_avatar.png"

	    if @user.save #(permit_params)
	      sign_in @user
      	@notice = "Success! Please update your details below."
	      redirect_to edit_user_path(@user), :notice => @notice and return
	    end
		end
		render 'new'
		# redirect_to sign_up_path, :notice => "Password does not match!"
  	end

  	def update
	    if @user.update_attributes(permit_params)
	      flash[:success] = "Profile updated"
	      redirect_to @user
	    else
	      render 'edit'
	    end
	end

	def destroy
		@user.destroy
    flash[:success] = "User deleted"
    redirect_to root_path
	end

  private

		def find_user
			@user = User.find(params[:id])
		end

	  def permit_params
	    params.require(:user).permit(:name, :email, :encrypted_password, :password, :confirmation_token, :remember_token, :avatar, :location, :state, :country, :description)
	  end

	  def match_password
			true if params[:user][:password] = params[:user][:password_confirmation]
		end
end
