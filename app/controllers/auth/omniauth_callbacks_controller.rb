# frozen_string_literal: true

class Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :secondlife_regist_user
  before_action :require_grid_access!, only: [:secondlife_regist_object, :secondlife_regist_user]

  def mastodon
    account = FollowRemoteAccountService.new.call(request.env['omniauth.auth']['uid'])
    
    if user_signed_in?
      RemoteAccount.create(user_id: current_user.id, account_id: account.id)
      redirect_to settings_remote_accounts_url
    else
      remote = account.remote_accounts.first
      if remote
        sign_in_and_redirect remote.user, :event => :authentication
      else
        # TODO error message
        redirect_to new_user_session_url
      end
    end
  end

  def secondlife
    account = SecondlifeAccount.find_by!(token: params[:token])
    account.regenerate_token

    if user_signed_in?
      account.update(user_id: current_user.id)
      redirect_to settings_remote_accounts_url
    else
      user = account.user
      if user
        sign_in_and_redirect user, :event => :authentication
      else
        # TODO sign up
        redirect_to new_user_session_url
      end
    end
  end

  def secondlife_regist_object
    setting = Setting.find_or_initialize_by(var: 'secondlife_region')
    setting.update(value: request.env['HTTP_X_SECONDLIFE_REGION'])

    setting = Setting.find_or_initialize_by(var: 'secondlife_local_position')
    setting.update(value: request.env['HTTP_X_SECONDLIFE_LOCAL_POSITION'])

    render json: { status: 'OK' }, status: 200
  end

  def secondlife_regist_user
    account = SecondlifeAccount.find_or_initialize_by(key: params[:key])
    account.legacy_name = params[:legacy_name]
    account.display_name = params[:display_name]
    account.user_name = params[:user_name]
    account.save!
    account.regenerate_token

    render json: { status: 'OK', token: account.token }, status: 200
  end
  
  private

  def require_grid_access!
    render json: { error: 'This action requires an grid access' }, status: 403 unless valid_grid_access?
  end

  def valid_grid_access?
    # Simulator IP Addresses http://wiki.secondlife.com/wiki/Simulator_IP_Addresses
    return false unless %w(8.2.32.0/22 8.4.128.0/22 8.10.144.0/21 63.210.156.0/22 64.154.220.0/22 216.82.0.0/18).any? {|range| IPAddr.new(range).include?(request.ip)}
    return false unless request.env['HTTP_X_SECONDLIFE_SHARD'] == 'Production'
    return false unless request.env['HTTP_X_SECONDLIFE_OWNER_KEY'] == Setting.find_by(var: 'secondlife_avatar_uuid')&.value
    true
  end
end
