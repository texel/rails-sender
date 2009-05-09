# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  before_filter :login_required, :credentials_required
  
  protected
  
  def credentials_required
    redirect_to new_credentials_url and return false unless current_user && current_user.credentials?
  end
  
  def prepare_user_ds_connection
    prepare_user_ds_connection(current_user.api_login, current_user.api_password)
  end
    
  def prepare_ds_connection(user_name, password)
    @connection = Docusign::Base.login(
      :user_name    => user_name,
      :password     => password,
      :endpoint_url => Docusign::Config[:default_endpoint_url]
    )
  end
end
