# frozen_string_literal: true

class Settings::RemoteAccountsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def index    
  end

  def new
    session[:identifier] = nil
    redirect_to user_mastodon_omniauth_authorize_url
  end

  def destroy
    current_user.remote_accounts.find(params[:id]).destroy
    redirect_to settings_remote_accounts_url
  end  
end
