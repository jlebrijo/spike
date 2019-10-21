class ApplicationController < ActionController::Base
  before_action :include_devise_token_auth_if_json_request
  private
    def include_devise_token_auth_if_json_request
      if request.format.json?
        self.class.send(:include, "DeviseTokenAuth::Concerns::SetUserByToken".constantize)
      end
    end
end
