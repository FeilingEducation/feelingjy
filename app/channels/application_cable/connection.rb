# See http://guides.rubyonrails.org/action_cable_overview.html#connection-setup
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      puts '=============Connectig==============='
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    protected

    def find_verified_user # this checks whether a user is authenticated with devise
      # if verified_user = env['warden'].user
      if verified_user = User.find_by(id: cookies.signed['user.id'])
        verified_user
      else
        puts '=============Rejecting ... find_verified_user==============='
        reject_unauthorized_connection
      end
    end
  end
end
