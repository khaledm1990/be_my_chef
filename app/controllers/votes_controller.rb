class VotesController < ApplicationController

	def create
		@user = User.find(params[:voted_id])
		@cast = params[:vote][:cast]
		current_user.vote(@user, @cast)

		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end

end
