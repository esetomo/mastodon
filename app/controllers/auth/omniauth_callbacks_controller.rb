# frozen_string_literal: true

class Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
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
  end
end
