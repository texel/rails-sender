class AuthenticationTokensController < ApplicationController
  
  def new
    @envelope = Envelope.find params[:envelope_id]
    
    prepare_user_ds_connection
    
    begin
      @token_response = @connection.getAuthenticationToken :goToEnvelopeID => @envelope.ds_id
    rescue SOAP::FaultError => e
      @token_respone = e.message
    end
    
    respond_to do |wants|
      if @token_response.is_a?(Docusign::GetAuthenticationTokenResponse)
        wants.html { }
      else
        flash[:error] = "There was a problem with your request: #{@token_response}. Please try again"
      end
    end
  end
end
