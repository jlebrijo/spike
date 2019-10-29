class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: :json_request?
  before_action :include_devise_token_auth, if: :json_request?

  private
    def include_devise_token_auth
      self.class.send(:include, "DeviseTokenAuth::Concerns::SetUserByToken".constantize)
    end
    def json_request?
      request.format.json?
    end
end
