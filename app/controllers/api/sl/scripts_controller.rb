# frozen_string_literal: true

module Api::Sl
  class ScriptsController < BaseController
    def create
      script = SecondlifeScript.find_or_initialize_by(prim_key: request.env['HTTP_X_SECONDLIFE_OBJECT_KEY'])
      script.script_url = params[:script_url]
      script.secondlife_account = SecondlifeAccount.find_or_create_by(key: request.env['HTTP_X_SECONDLIFE_OWNER_KEY'])
      script.save!
      
      render plain: 'script registered', status: 200
    end
  end
end
