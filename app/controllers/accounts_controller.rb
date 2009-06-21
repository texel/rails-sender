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

class AccountsController < ApplicationController
  # GET /accounts
  # GET /accounts.xml
  def index
    @accounts = current_user.accounts.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.xml
  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.xml
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.xml
  def create
    @account = current_user.accounts.build params[:account]
    
    account_array = accounts_from_credentials @account.api_email, @account.api_password
    
    accounts = account_array.map do |account_info|
      account = current_user.accounts.build params[:account]
      
      account.api_id       = account_info.accountID
      account.api_name     = account_info.accountName
      account.api_user_id  = account_info.userID
      
      account
    end

    respond_to do |format|
      if !accounts.blank? && accounts.map(&:valid?).all? && accounts.map(&:save).all?
        flash[:notice] = "#{accounts.size == 1 ? 'Account was' : "#{accounts.size} accounts were"} successfully created."
        format.html { redirect_to(@account) }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.xml
  def update
    @account = account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        flash[:notice] = 'account was successfully updated.'
        format.html { redirect_to(@account) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @account = Account.find params[:id]
    
    @account.destroy
    
    respond_to do |wants|
      wants.html { redirect_to :action => 'index' }
    end
  end
  
  protected
  
  def accounts_from_credentials(email, password)
    result = Docusign::Base.credentials(email, password, Docusign::Config[:credential_endpoint_url])
    if result.success?
      result.accounts
    else
      flash[:error] = result.authenticationMessage
      []
    end
  end
end
