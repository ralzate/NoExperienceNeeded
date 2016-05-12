class JobSeekersController < ApplicationController
     @showEditFeatures = false
	def show
		if params.has_key?(:id) 

			if is_valid_id params[:id].to_i

				@jobseeker = JobSeeker.find(params[:id])
				@user = User.find(@jobseeker.user_id)
				@portfolio = PortfolioItem.where(job_seeker_id: @jobseeker.id)

				if is_same_as_logged_in_job_seeker @user
					@showEditFeatures = true
				end
			else
				redirect_to login_path
			end

		elsif current_user
			@user = current_user
			@jobseeker = JobSeeker.find_by(user_id: @user.id)
			@portfolio = PortfolioItem.where(job_seeker_id: @jobseeker.id)
			@showEditFeatures = true


		else
			redirect_to login_path
		end

	end

	def new_portfolio_item
		@seeker_id = params[:id]
		respond_to do |format|
			format.js
		end
	end

	def save_portfolio_item
		job_seeker_id = params[:id].to_i
		PortfolioItem.create(:job_seeker_id => params[:id], :url => params[:URL], :project_type => params[:itemType], :description => params[:description], :name => params[:title] )
		redirect_to '/profile/'
	end

	def dashboard
		@user = User.find(params[:user])
		@job_seeker = JobSeeker.find_by(user_id: @user.id)
		@shortlisted = ShortListedJob.where(job_seeker_id: @job_seeker.id)
	end

	def is_same_as_logged_in_job_seeker user
		return user == current_user
	end

	def is_valid_id id
		JobSeeker.all.each do |seeker|
			if seeker.id == id
				return true
			end
		end
		return false
	end

end