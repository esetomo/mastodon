# frozen_string_literal: true

module Api::Sl
  class TerminalsController < BaseController
    def create
      setting = Setting.find_or_initialize_by(var: 'secondlife_region')
      setting.update(value: request.env['HTTP_X_SECONDLIFE_REGION'])

      setting = Setting.find_or_initialize_by(var: 'secondlife_local_position')
      setting.update(value: request.env['HTTP_X_SECONDLIFE_LOCAL_POSITION'])

      render json: { status: 'OK' }, status: 200
    end
  end
end

