# frozen_string_literal: true

class Settings::InstancesController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :set_account

  def index    
  end

  def new
    session[:identifier] = nil
    redirect_to user_mastodon_omniauth_authorize_url
  end

  def destroy
    OtherInstanceAccount.find(params[:id]).destroy
    redirect_to settings_instances_url
  end
  
  private

  def set_account
    @account = current_user.account
  end
end
