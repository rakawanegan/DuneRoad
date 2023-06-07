class UserController < ApplicationController
  def show
  	@user = current_user
  	@tokens = Token.where(holder:(current_user.id))
  end
  
  def charge
  	
  end
  def asset_update
  	begin
	  	current_user.assets += params[:add_asset].values[0].to_f
	rescue => e
		p e
	end
  	if current_user.save
  		redirect_to user_profile_path
  	end
  	
  end
end
