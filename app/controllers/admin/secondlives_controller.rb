# frozen_string_literal: true

module Admin
  class SecondlivesController < BaseController
    def show
      @setting = OpenStruct.new
      @setting.avatar_uuid = Setting.find_by(var: 'secondlife_avatar_uuid')&.value
    end

    def update
      setting = Setting.find_or_initialize_by(var: 'secondlife_avatar_uuid')
      setting.update(value: params[:setting][:avatar_uuid])
        
      redirect_to admin_secondlife_url
    end
  end
end
