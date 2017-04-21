# frozen_string_literal: true

class Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def mastodon
    uid = request.env['omniauth.auth']['uid']
    url = request.env['omniauth.auth']['info']['urls']['Profile']
    other = OtherInstanceAccount.find_by(uid: uid)
    
    if user_signed_in?
      if other
        # TODO error
      else
        OtherInstanceAccount.create(account_id: current_user.account_id,
                                    uid: uid,
                                    url: url)
      end
      redirect_to settings_instances_url
    else    
      account = other&.account
      if account
        sign_in_and_redirect account.user, :event => :authentication
      else
        # TODO error message
        redirect_to new_user_session_url
      end
    end
  end
end
