class ApplicationController < ActionController::Base
  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    respond_to do |format|
      format.html { render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false }
      format.json { head :not_found }
      format.atom { head :not_found }
    end
  end
	protect_from_forgery
	helper_method :current_user
	before_filter :require_login

	private
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	 def require_login
	# 	unless logged_in?
	# 		flash[:error] = t 'users.you_must_be_logged'
	# 		# redirect_to log_in_url
	# 	end
	 end

	# The logged_in? method simply returns true if the user is logged
	# in and false otherwise. It does this by "booleanizing" the
	# current_user method we created previously using a double ! operator.
	# Note that this is not common in Ruby and is discouraged unless you
	# really mean to convert something into true or false.
	def logged_in?
		!!current_user
	end
end
