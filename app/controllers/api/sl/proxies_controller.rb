# frozen_string_literal: true

module Api::Sl
  class ProxiesController < BaseController
    skip_before_action :require_grid_access!, only: :show, :callback
    
    def show
      proxy = SecondlifeProxy.find_by(domain: params[:domain])
      unless proxy
        client = Mastodon::REST::Client.new(base_url: "https://#{params[:domain]}")
        app = client.create_app("SL Proxy #{Mastodon::Application.config.x.local_domain}", callback_api_sl_proxy_url, 'read write')
        proxy = SecondlifeProxy.create!(domain: params[:domain], client_id: app.client_id, client_secret: app.client_secret)
      end

      url = Addressable::URI.new
      url.host = params[:domain]
      url.path = '/oauth/authorize'
      url.scheme = 'https'
      url.query_values = {
        client_id: proxy.client_id,
        response_type: 'code',
        redirect_uri: callback_api_sl_proxy_url,
        scope: 'read write'
      }
      
      redirect_to url.to_s
    end

    def callback
      
    end
  end
end
