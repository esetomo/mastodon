# frozen_string_literal: true

class Settings::SecondlifeAccountsController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!

  def new
    region = /^[^\(]+/.match(Setting['secondlife_region'])[0].strip
    m = /^\((\d+\.\d+), (\d+\.\d+), (\d+\.\d+)\)$/.match(Setting['secondlife_local_position'])
    redirect_to "http://maps.secondlife.com/secondlife/#{region}/#{m[1]}/#{m[2]}/#{m[3]}"
  end
  
  def destroy
    current_user.secondlife_accounts.find(params[:id]).destroy
    redirect_to settings_remote_accounts_url
  end
end
