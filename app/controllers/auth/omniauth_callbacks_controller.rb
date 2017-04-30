# frozen_string_literal: true

class Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def mastodon
    return redirect_to :about unless current_user
    
    account = FollowRemoteAccountService.new.call(request.env['omniauth.auth']['uid'])
    RemoteAccount.create(user_id: current_user.id, account_id: account.id)
    redirect_to settings_remote_accounts_url
  end
end
