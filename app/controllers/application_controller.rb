class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user,
                :passwords_match?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def passwords_match?(path)
    params[path]['password'] == params[path]['verify_password']
  end

end
