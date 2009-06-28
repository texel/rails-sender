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

class RecipientsController < ApplicationController
  before_filter :find_envelope
  before_filter :ensure_envelope_pending, :only => [:new, :create, :edit, :update]
  # GET /recipients
  # GET /recipients.xml
  def index
    @recipients = Recipient.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recipients }
    end
  end

  # GET /recipients/1
  # GET /recipients/1.xml
  def show
    @recipient = Recipient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipient }
    end
  end

  # GET /recipients/new
  # GET /recipients/new.xml
  def new
    @recipient = Recipient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @recipient }
    end
  end

  # GET /recipients/1/edit
  def edit
    @recipient = Recipient.find(params[:id])
  end

  # POST /recipients
  # POST /recipients.xml
  def create
    @recipient = @envelope.recipients.build(params[:recipient])

    respond_to do |format|
      if @recipient.save
        flash[:notice] = 'Recipient was successfully created.'
        format.html { redirect_to(account_envelope_url(@envelope.account, @envelope)) }
        format.xml  { render :xml => @recipient, :status => :created, :location => @recipient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recipient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recipients/1
  # PUT /recipients/1.xml
  def update
    @recipient = Recipient.find(params[:id])

    respond_to do |format|
      if @recipient.update_attributes(params[:recipient])
        flash[:notice] = 'Recipient was successfully updated.'
        format.html { redirect_to account_envelope_url(@envelope.account, @envelope) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recipient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recipients/1
  # DELETE /recipients/1.xml
  def destroy
    @recipient = Recipient.find(params[:id])
    @recipient.destroy

    respond_to do |format|
      format.html { redirect_to(account_envelope_url(@envelope.account, @envelope)) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def find_envelope
    redirect_to root_url and return false unless @envelope = current_user.envelopes.find(params[:envelope_id])
  end
  
  def ensure_envelope_pending
    unless @envelope.pending?
      flash[:error] = "You cannot modify recipients for a sent envelope!"
      redirect_to account_envelope_url(@envelope.account, @envelope) and return false
    end
  end
end
