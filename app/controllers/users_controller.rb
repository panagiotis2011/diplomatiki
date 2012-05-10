# encoding: utf-8
class UsersController < ApplicationController

	def update
		@user = User.find(params[:id])

		respond_to do |format|
			if @user.update_attributes(params[:user])
				format.html { redirect_to(@user, :notice => 'Ο χρήστης ενημερώθηκε επιτυχώς.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
			end
		end
	end

	def destroy
			@user = User.find(params[:id])
			if current_user.id < 2
				@user.destroy
			else
				flash[:error] = 'δεν μπορεί να διαγραφεί.'
			end
		end
		respond_to do |format|
			format.html { redirect_to(users_url) }
			format.xml  { head :ok }
		end
	end
