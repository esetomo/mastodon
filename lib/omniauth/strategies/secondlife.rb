module OmniAuth
  module Strategies
    class Secondlife
      include OmniAuth::Strategy

      option :name, 'secondlife'
      option :land_url
      
      def request_phase
        redirect options[:land_url]
      end
    end
  end
end
