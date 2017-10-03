class WelcomeController < ApplicationController
  before_action :require_login
  def index
  end
 
  private
 
  def require_login
  	if cookies['user'].present?
  		redirect_to "/products"
  	end
  end
end
