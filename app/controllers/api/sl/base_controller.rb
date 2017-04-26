# frozen_string_literal: true

class Api::Sl::BaseController < ApiController
  before_action :require_grid_access!

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
