class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include Pundit

	private
		def authorize_admin_user
			authorize User
		end
end
