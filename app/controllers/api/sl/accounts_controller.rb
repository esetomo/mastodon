# frozen_string_literal: true

module Api::Sl
  class AccountsController < BaseController
    skip_before_action :require_grid_access!, only: :callback
    
    def create
      account = SecondlifeAccount.find_or_initialize_by(key: params[:key])
      account.legacy_name = params[:legacy_name]
      account.display_name = params[:display_name]
      account.user_name = params[:user_name]
      account.save!
      account.regenerate_token

      render json: { status: 'OK', token: account.token }, status: 200
    end

    def callback
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
  end
end

