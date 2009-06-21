# Copyright (C) DocuSign, Inc.  All rights reserved.
# 
# This source code is intended only as a supplement to DocuSign SDK 
# and/or on-line documentation.
# 
# This sample is designed to demonstrate DocuSign features and is not intended 
# for production use. Code and policy for a production application must be 
# developed to meet the specific data and security requirements of the 
# application.
# 
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
# KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
# PARTICULAR PURPOSE.

class EnvelopesController < ApplicationController
  # GET /envelopes
  # GET /envelopes.xml
  before_filter :find_account
  before_filter :find_envelope, :except => [:index, :new, :create]
  
  def index
    @envelopes = @account.envelopes.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @envelopes }
    end
  end

  # GET /envelopes/1
  # GET /envelopes/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @envelope }
    end
  end

  # GET /envelopes/new
  # GET /envelopes/new.xml
  def new
    @envelope = Envelope.new
    @envelope.recipients.build if @envelope.recipients.blank?

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @envelope }
    end
  end

  # GET /envelopes/1/edit
  def edit
    @envelope = Envelope.find(params[:id])
  end

  # POST /envelopes
  # POST /envelopes.xml
  def create
    @envelope = @account.envelopes.build(params[:envelope])

    respond_to do |format|
      if @envelope.save
        flash[:notice] = 'Envelope was successfully created.'
        format.html { redirect_to(account_envelope_url(@account, @envelope)) }
        format.xml  { render :xml => @envelope, :status => :created, :location => @envelope }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @envelope.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /envelopes/1
  # PUT /envelopes/1.xml
  def update
    @envelope = @account.envelopes.find(params[:id])

    respond_to do |format|
      if @envelope.update_attributes(params[:envelope])
        flash[:notice] = 'Envelope was successfully updated.'
        format.html { redirect_to(account_envelope_url(@account, @envelope)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @envelope.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def send_envelope
    @envelope = @account.envelopes.find(params[:id])
    
    respond_to do |wants|
      if @envelope.pending?
        @ds_envelope = @envelope.to_ds_envelope

        @response = @account.ds_connection.createAndSendEnvelope :envelope => @ds_envelope
                
        if @response.is_a?(Docusign::CreateAndSendEnvelopeResponse)
          @result = @response.createAndSendEnvelopeResult
          @envelope.ds_id = @result.envelopeID
          @envelope.ds_status = @result.status
          @envelope.status_updated_at = Time.now
          @envelope.send_envelope! # Trigger state change
        end
        
        wants.html { redirect_to account_envelope_url(@account, @envelope) }
      else
        flash[:error] = "Envelope was already sent!"
        wants.html { redirect_to :action => 'index' }
      end
    end
  end
  
  def refresh_status
    @envelope = Envelope.find(params[:id])
    
    @response = @account.ds_connection.requestStatus :envelopeID => @envelope.ds_id
    @result   = @response.requestStatusResult
    @envelope.ds_status = @result.status
    @envelope.status_updated_at = Time.now
    @envelope.save
    
    respond_to do |wants|
      wants.html { redirect_to account_envelope_url(@account, @envelope) }
    end
  end

  # DELETE /envelopes/1
  # DELETE /envelopes/1.xml
  def destroy
    @envelope = Envelope.find(params[:id])
    @envelope.destroy

    respond_to do |format|
      format.html { redirect_to(envelopes_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def find_account
    redirect_to root_url and return false unless @account = current_user.accounts.find(params[:account_id])
  end
  
  def find_envelope
    @envelope = @account.envelopes.find(params[:id])
  end
end
