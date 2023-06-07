class TokenController < ApplicationController
	before_action :authenticate_user!, except: [:index,:search]
	
	
	def index
		@tokens = Token.all
	end

	def search
		@word = params[:search]
		@tasks = Token.where('tag LIKE ?',"%#{@word}%") if @word.present?
	end

	def purchase
	#add cash back
		if user_signed_in?
			@token = Token.find(params[:token_id])
			balance = current_user.assets - @token.price
			
			if balance > 0
				add = @token.price * 0.8
				
				if (@token.pre_holder).nil?
					old_holders =  (current_user.id).to_s
				else
					old_holders = @token.pre_holder + " " + (current_user.id).to_s
      				end
      				
      				if @token.update(holder:(current_user.id), admin: true, pre_holder: old_holders)
	 	     			if current_user.update(assets: balance)
	 	     				redirect_to user_profile_path
	 	     			end
	     			end
	     		else
	     			redirect_to charge_path_path
	     		end
	     		
	     	else
	     		redirect_to user_session_path
	     	end
	end
	
	def release
		@token = Token.find(params[:token_id])
      		if @token.update(admin: false,)
	      		redirect_to user_profile_path
	      	end
	
	end
	
	def new
		@token = Token.new
	end
	
	def download
		@token = Token.find(params[:token_id])
		send_file "public/img/#{@token.image}"
	end
	
	def create
     		@token = Token.new(token_params)
     		tokens = Token.all
     		@token.image = token_params[:image].original_filename
     		    File.open("public/img/#{@token.image}", 'wb') { |f|
     			 f.write(token_params[:image].read)
			}
     		if tokens.maximum(:token_id).nil?
     			id_max_add1 = 1
     		else
     			id_max_add1 = tokens.maximum(:token_id) + 1
     		end
     		@token.token_id = id_max_add1
     		if @token.title.nil? or @token.image.nil? or @token.detail.nil? or @token.price.nil?
     			redirect_to exhibit_path_path
      		elsif @token.save
      			redirect_to exhibit_path_url
      		end
    	end

	    private
        	def token_params
        	    params.require(:token).permit(
        	    :title, :image, :detail, :price, :holder, :tag, :summary)
        	end
end
