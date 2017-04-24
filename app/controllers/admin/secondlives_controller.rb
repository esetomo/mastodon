# frozen_string_literal: true

module Admin
  class SecondlivesController < BaseController
    def show
      @secondlife_secret = Setting.find_by(var: 'secondlife_secret')&.value
      @secondlife_land_url = Setting.find_by(var: 'secondlife_land_url')&.value
    end

    def update
      setting = Setting.find_or_initialize_by(var: 'secondlife_secret')
      setting.update(value: ActiveRecord::Base.generate_unique_secure_token)
        
      redirect_to admin_secondlife_url
    end
  end
end
