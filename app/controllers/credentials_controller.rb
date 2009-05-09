class CredentialsController < ApplicationController
  layout "docusign"
  
  skip_before_filter :credentials_required
  
  def new
    respond_to do |wants|
      wants.html {  }
    end
  end
  
  def create
    prepare_ds_connection(params[:user][:api_login], params[:user][:api_password])

    begin
      @response = @connection.ping(true)
    rescue SOAP::FaultError => e
      @response = e.message
    end
    
    respond_to do |wants|
      if @response.is_a?(Docusign::PingResponse)
        # Successful ping! Let's save [the user's credentials
        current_user.api_login    = params[:user][:api_login]
        current_user.api_password = params[:user][:api_password]
        current_user.save
        wants.html { redirect_to user_url(current_user) }
      else
        flash[:error] = @ds_response.inspect
        wants.html { render :action => 'new'}
      end
    end
  end
end